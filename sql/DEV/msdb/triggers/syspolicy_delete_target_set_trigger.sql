USE [msdb]
GO

CREATE   TRIGGER [dbo].[syspolicy_delete_target_set_trigger] ON [dbo].[syspolicy_target_sets_internal]
FOR DELETE
AS
BEGIN
	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN;
	END

    DECLARE @update_notifications INT
    DECLARE @update_ddl_trigger   INT

    SET @update_notifications = 0
    SET @update_ddl_trigger = 0

    -- If this is cascade delete, there will be no policies to join
    SELECT @update_notifications = SUM (p.execution_mode & 2), @update_ddl_trigger = SUM (p.execution_mode & 1)
        FROM deleted d
        JOIN msdb.dbo.syspolicy_object_sets_internal os ON d.object_set_id = os.object_set_id
        JOIN msdb.dbo.syspolicy_policies p ON (os.object_set_id = p.object_set_id)
        WHERE ((p.execution_mode & 3) > 0 AND p.is_enabled = 1)

    IF (@update_ddl_trigger > 0)
        EXEC sys.sp_syspolicy_update_ddl_trigger

    IF    (@update_notifications > 0)
        EXEC sys.sp_syspolicy_update_event_notification
END
GO
