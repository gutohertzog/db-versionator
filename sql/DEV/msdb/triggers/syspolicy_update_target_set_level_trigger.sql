USE [msdb]
GO

CREATE   TRIGGER [dbo].[syspolicy_update_target_set_level_trigger] ON [dbo].[syspolicy_target_set_levels_internal]
FOR UPDATE
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

    IF UPDATE(condition_id)
    BEGIN
		DECLARE @level sysname
		SET @level = NULL

		-- Don't allow setting non-db levels for runtime policies
        SELECT TOP 1 @level = i.level_name
			FROM inserted i
			JOIN dbo.syspolicy_target_sets s ON (i.target_set_id = s.target_set_id)
			JOIN msdb.dbo.syspolicy_object_sets os ON s.object_set_id = os.object_set_id
			JOIN msdb.dbo.syspolicy_policies p ON (os.object_set_id = p.object_set_id)
			WHERE 1 = dbo.syspolicy_fn_filter_complete (i.target_set_id) AND
				((p.execution_mode & 3) > 0 AND 0 = dbo.syspolicy_fn_eventing_filter (i.target_set_id))
		IF @level IS NOT NULL
        BEGIN
            RAISERROR(34016, -1, -1, @level)
            ROLLBACK TRANSACTION
        END
    END

    SELECT @update_notifications = SUM (p.execution_mode & 2), @update_ddl_trigger = SUM (p.execution_mode & 1)
        FROM inserted i
        JOIN dbo.syspolicy_target_sets s ON (i.target_set_id = s.target_set_id)
        JOIN msdb.dbo.syspolicy_object_sets os ON s.object_set_id = os.object_set_id
        JOIN msdb.dbo.syspolicy_policies p ON (os.object_set_id = p.object_set_id)
        WHERE 1 = dbo.syspolicy_fn_filter_complete (i.target_set_id) AND
            ((p.execution_mode & 3) > 0 AND p.is_enabled = 1 AND 1 = dbo.syspolicy_fn_eventing_filter (i.target_set_id))

    IF (@update_ddl_trigger > 0)
        EXEC sys.sp_syspolicy_update_ddl_trigger

    IF    (@update_notifications > 0)
        EXEC sys.sp_syspolicy_update_event_notification

END
GO
