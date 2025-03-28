USE [msdb]
GO

CREATE   TRIGGER [dbo].[syspolicy_insert_target_set_trigger]
    ON [dbo].[syspolicy_target_sets_internal]
FOR INSERT
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

    -- Only need to check Server TargetSets, as they don't have levels
    SELECT @update_notifications = SUM (p.execution_mode & 2), @update_ddl_trigger = SUM (p.execution_mode & 1)
        FROM inserted i
        JOIN msdb.dbo.syspolicy_object_sets_internal os ON i.object_set_id = os.object_set_id
        JOIN msdb.dbo.syspolicy_policies p ON (os.object_set_id = p.object_set_id)
        WHERE i.type = 'SERVER' AND ((p.execution_mode & 3) > 0 AND p.is_enabled = 1)

    IF (@update_ddl_trigger > 0)
        EXEC sys.sp_syspolicy_update_ddl_trigger

    IF    (@update_notifications > 0)
        EXEC sys.sp_syspolicy_update_event_notification
END
GO
