USE [msdb]
GO

CREATE   TRIGGER [dbo].[syspolicy_insert_job_create_trigger] on [dbo].[syspolicy_policies_internal]
FOR INSERT
AS
BEGIN
	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN;
	END

	-- protect against non-scheduled automation jobs
	-- that have expressions that execute script
	DECLARE @row_count int

    SELECT @row_count = count(*)
        FROM syspolicy_conditions c
        INNER JOIN inserted i ON (i.condition_id = c.condition_id OR i.root_condition_id = c.condition_id)
        WHERE    i.is_enabled != 0 AND
                i.execution_mode != 4 AND
                (1 = CONVERT(xml, c.expression).exist('//FunctionType/text()[.="ExecuteSql"]' ) OR
                1 = CONVERT(xml, c.expression).exist('//FunctionType/text()[.="ExecuteWql"]' ) )
        OPTION (FORCE ORDER);

    SELECT @row_count = @row_count + count(*)
        FROM dbo.syspolicy_target_set_levels l
        INNER JOIN dbo.syspolicy_target_sets s ON s.target_set_id = l.target_set_id
        INNER JOIN syspolicy_conditions c on c.condition_id = l.condition_id
        INNER JOIN syspolicy_object_sets_internal os ON os.object_set_id = s.object_set_id
        INNER JOIN inserted i ON os.object_set_id = i.object_set_id
        WHERE    i.is_enabled != 0 AND
                i.execution_mode != 4 AND
                (1 = CONVERT(xml, c.expression).exist('//FunctionType/text()[.="ExecuteSql"]' ) OR
                1 = CONVERT(xml, c.expression).exist('//FunctionType/text()[.="ExecuteWql"]' ) )
        OPTION (FORCE ORDER);

    IF (@row_count > 0)
    BEGIN
        RAISERROR(34017, -1, -1);
        ROLLBACK TRANSACTION;
    END

	DECLARE @jobID uniqueidentifier
	DECLARE @schedule_uid uniqueidentifier
	DECLARE @is_enabled bit

	-- verify that values in inserted.schedule_uid are valid
	IF EXISTS (
		SELECT * FROM inserted i
		WHERE i.schedule_uid NOT IN
				(SELECT schedule_uid FROM msdb.dbo.sysschedules ) AND
		((i.execution_mode & 4) = 4))
	BEGIN
		ROLLBACK -- Failure
		RAISERROR (14365, -1, -1)
		RETURN
	END

	-- find all schedules referenced by the inserted policies for which
	-- there is no agent job that executes the policies
	DECLARE schedule_cursor CURSOR LOCAL FOR
	    SELECT DISTINCT i.schedule_uid
	    FROM inserted i
	    WHERE
		    ((i.execution_mode & 4) = 4) AND
	        NOT EXISTS (SELECT *
	                        FROM msdb.dbo.syspolicy_policies p
	                        WHERE
	                            p.policy_id NOT IN (SELECT policy_id FROM inserted) AND
	                            p.schedule_uid = i.schedule_uid AND
	                            ((p.execution_mode & 4) = 4) )

	-- iterate through the cursor and create a job for every schedule
	OPEN schedule_cursor
	FETCH schedule_cursor INTO @schedule_uid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- figure out if the job is enabled or not
		SELECT @is_enabled = COUNT(*)
		FROM inserted i
		WHERE i.schedule_uid = @schedule_uid AND i.is_enabled = 1

		-- explicitly nullify jobID,
		-- (if we need to create more than 1 job, it will not be null and sp_add_job will think we're getting job from MSX)
		SET @jobID = NULL

		-- create the job that is going to execute the schedule
		EXEC [msdb].[dbo].[sp_syspolicy_create_job] @schedule_uid, @is_enabled, @jobID OUTPUT

		-- update the job_id back into the policies table
		UPDATE p SET p.job_id = @jobID
			FROM msdb.dbo.syspolicy_policies_internal p
			INNER JOIN inserted i ON p.policy_id = i.policy_id
		WHERE
			i.schedule_uid = @schedule_uid AND
			(i.execution_mode & 4) = 4

		FETCH schedule_cursor INTO @schedule_uid
	END

	CLOSE schedule_cursor
	DEALLOCATE schedule_cursor

	-- in case we haven't created the job we still need to update
	-- the policies with their jobID
	UPDATE p
		SET p.job_id = ( SELECT TOP 1 p2.job_id
						FROM msdb.dbo.syspolicy_policies p2
						WHERE
							p2.schedule_uid = p.schedule_uid AND
							p2.job_id IS NOT NULL)
		FROM msdb.dbo.syspolicy_policies_internal p
		INNER JOIN inserted i ON p.policy_id = i.policy_id
		WHERE
			((p.execution_mode & 4) = 4) AND
			p.job_id IS NULL

	-- See what jobs we need to enable.
	-- This can happen because we might create a new policy that
	-- is enabled and there is already a job for it, but the existing
	-- job is disabled
	DECLARE jobs_to_enable CURSOR LOCAL FOR
		SELECT DISTINCT j.job_id
		FROM dbo.sysjobs_view j
		JOIN msdb.dbo.syspolicy_policies p ON p.job_id = j.job_id
		JOIN inserted i ON p.policy_id = i.policy_id
		WHERE
			((i.execution_mode & 4) = 4) AND
			j.enabled = 0 AND
			EXISTS ( SELECT * from msdb.dbo.syspolicy_policies p2
						WHERE p2.job_id = j.job_id AND p2.is_enabled = 1)

	OPEN jobs_to_enable
	FETCH jobs_to_enable INTO @jobID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC msdb.dbo.sp_update_job @job_id = @jobID, @enabled = 1

		FETCH jobs_to_enable INTO @jobID
	END
	CLOSE jobs_to_enable
	DEALLOCATE jobs_to_enable

	-- enable events infrastructure
	IF EXISTS ( SELECT * FROM inserted i WHERE ((i.execution_mode & 1) = 1))
	BEGIN
		EXEC sys.sp_syspolicy_update_ddl_trigger
	END

	IF EXISTS (SELECT * FROM inserted i WHERE ((i.execution_mode & 2) = 2))
	BEGIN
		EXEC sys.sp_syspolicy_update_event_notification
	END

	-- update owner information
	UPDATE msdb.dbo.syspolicy_policies_internal
	SET created_by = original_login(),
		date_created = getdate (),
		date_modified = NULL,
		modified_by = NULL
	FROM inserted i,
	   msdb.dbo.syspolicy_policies_internal policies
	WHERE i.policy_id = policies.policy_id

END -- create trigger
GO
