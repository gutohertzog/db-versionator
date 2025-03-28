USE [msdb]
GO

CREATE   TRIGGER [dbo].[syspolicy_update_job_update_trigger] on [dbo].[syspolicy_policies_internal]
FOR UPDATE
AS
BEGIN
	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN;
	END

	-- This is to prevent indirect entrance of the trigger
	IF (TRIGGER_NESTLEVEL() > 1) RETURN

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

	-- update eventing infrastructure
	IF(UPDATE(execution_mode) OR UPDATE(is_enabled))
	BEGIN
		IF  EXISTS (SELECT *
					FROM inserted i
					INNER JOIN deleted d ON i.policy_id = d.policy_id
					WHERE
						(((i.execution_mode & 1) = 1) OR ((d.execution_mode & 1) = 1)) AND
						(i.is_enabled != d.is_enabled OR i.execution_mode != d.execution_mode))
		BEGIN
			EXEC sys.sp_syspolicy_update_ddl_trigger
		END

		IF  EXISTS (SELECT *
					FROM inserted i
					INNER JOIN deleted d ON i.policy_id = d.policy_id
					WHERE
						(((i.execution_mode & 2) = 2) OR ((d.execution_mode & 2) = 2)) AND
						(i.is_enabled != d.is_enabled OR i.execution_mode != d.execution_mode))
		BEGIN
			EXEC sys.sp_syspolicy_update_event_notification
		END
	END

	DECLARE @jobID uniqueidentifier
	DECLARE @is_enabled bit
	DECLARE @schedule_uid uniqueidentifier

    -- set the job_id to NULL for all policies whose schedule_uid has changed
    -- so that we can create a job if needed
    UPDATE p
        SET p.job_id = NULL
        FROM msdb.dbo.syspolicy_policies p
        INNER JOIN inserted i ON p.policy_id = i.policy_id
        INNER JOIN deleted d ON d.policy_id = p.policy_id
        WHERE i.schedule_uid != d.schedule_uid

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
	                            p.schedule_uid = i.schedule_uid AND
	                            ((p.execution_mode & 4) = 4) AND
	                            p.job_id IS NOT NULL)

	-- iterate through the cursor and create a job for every schedule
	OPEN schedule_cursor
	FETCH schedule_cursor INTO @schedule_uid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- figure out if the job is enabled or not
		SELECT @is_enabled = COUNT(*)
		FROM inserted i
		WHERE i.schedule_uid = @schedule_uid AND i.is_enabled = 1

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
		FROM msdb.dbo.syspolicy_policies p
		INNER JOIN inserted i ON p.policy_id = i.policy_id
		WHERE
			((p.execution_mode & 4) = 4) AND
			p.job_id IS NULL

	-- if the execution_mode has changed then we need to clear the job references
	UPDATE p
		SET p.job_id = NULL
		FROM msdb.dbo.syspolicy_policies_internal p
		INNER JOIN inserted i ON p.policy_id = i.policy_id
		INNER JOIN deleted d ON p.policy_id = d.policy_id
		WHERE
			((i.execution_mode & 4) != 4) AND
			((d.execution_mode & 4) = 4) AND
			p.job_id IS NOT NULL

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

	-- Find out what jobs have to be deleted because the policy's schedule
	-- has changed
	IF (UPDATE(schedule_uid))
	BEGIN
		DECLARE deleted_cursor CURSOR LOCAL FOR
			SELECT DISTINCT d.job_id
			FROM deleted d
			WHERE
				((d.execution_mode & 4) = 4) AND
				d.job_id NOT IN (SELECT job_id FROM msdb.dbo.syspolicy_policies p
								WHERE
								((p.execution_mode & 4) = 4))

		OPEN deleted_cursor
		FETCH deleted_cursor INTO @jobID

		WHILE (@@FETCH_STATUS=0)
		BEGIN
			-- delete the job(s), but do not delete the shared schedule
			IF (@jobID IS NOT NULL)
				EXEC msdb.dbo.sp_delete_job @job_id = @jobID, @delete_unused_schedule = 0

			FETCH deleted_cursor INTO @jobID
		END -- while (@@FETCH_STATUS=0)

		CLOSE deleted_cursor
		DEALLOCATE deleted_cursor
	END	-- UPDATE(schedule_uid)


	-- See what jobs we need to disable.
	-- This can happen because we do not need to delete the job, but
	-- all policies that reference it are disabled.
	DECLARE jobs_to_disable CURSOR LOCAL FOR
		SELECT DISTINCT j.job_id
		FROM dbo.sysjobs_view j
		JOIN msdb.dbo.syspolicy_policies p ON p.job_id = j.job_id
		WHERE
			j.enabled = 1 AND
			NOT EXISTS ( SELECT * from msdb.dbo.syspolicy_policies p2
						WHERE p2.job_id = j.job_id AND p2.is_enabled = 1 AND ((p2.execution_mode & 4) = 4))

	OPEN jobs_to_disable
	FETCH jobs_to_disable INTO @jobID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC msdb.dbo.sp_update_job @job_id = @jobID, @enabled = 0

		FETCH jobs_to_disable INTO @jobID
	END
	CLOSE jobs_to_disable
	DEALLOCATE jobs_to_disable

    UPDATE msdb.dbo.syspolicy_policies_internal
    SET modified_by = original_login(),
        date_modified = GETDATE()
    FROM inserted i,
       msdb.dbo.syspolicy_policies_internal policies
    WHERE i.policy_id = policies.policy_id
END -- update trigger
GO
