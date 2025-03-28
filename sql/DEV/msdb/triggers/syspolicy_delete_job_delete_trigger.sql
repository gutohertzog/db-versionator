USE [msdb]
GO

CREATE   TRIGGER [dbo].[syspolicy_delete_job_delete_trigger] on [dbo].[syspolicy_policies_internal]
FOR DELETE
AS
BEGIN
	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN;
	END

	DECLARE @jobID uniqueidentifier

	-- Declare the cursor to iterate over the jobs that are only referenced
	-- by deleted policies. The jobs that are still referenced by active policies
	-- should not be deleted.
	DECLARE deleted_cursor CURSOR LOCAL FOR
		SELECT DISTINCT d.job_id
		FROM deleted d
		WHERE
			((d.execution_mode & 4) = 4) AND
			NOT EXISTS (SELECT * FROM msdb.dbo.syspolicy_policies p
							WHERE
							p.job_id = d.job_id AND
							((p.execution_mode & 4) = 4) AND
							p.policy_id NOT IN (SELECT d2.policy_id FROM deleted d2))

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


	-- See what jobs we need to disable.
	-- This can happen because we do not need to delete the job, but
	-- all policies that reference it are disabled.
	DECLARE jobs_to_disable CURSOR LOCAL FOR
		SELECT DISTINCT j.job_id
		FROM dbo.sysjobs_view j
		JOIN deleted d ON d.job_id = j.job_id
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

	-- update eventing infrastructure
	IF EXISTS ( SELECT * FROM deleted d WHERE ((d.execution_mode & 1) = 1))
	BEGIN
		EXEC sys.sp_syspolicy_update_ddl_trigger
	END

	IF EXISTS (SELECT * FROM deleted d WHERE ((d.execution_mode & 2) = 2))
	BEGIN
		EXEC sys.sp_syspolicy_update_event_notification
	END

END
GO
