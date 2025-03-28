USE [msdb]
GO

CREATE   TRIGGER dbo.syspolicy_after_update_condition_trigger
ON msdb.dbo.syspolicy_conditions_internal
AFTER UPDATE
AS
BEGIN
	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN;
	END

	-- This is to prevent indirect entrance of the trigger
	IF (TRIGGER_NESTLEVEL() > 1)
		RETURN

    UPDATE msdb.dbo.syspolicy_conditions_internal
        SET modified_by = original_login(), date_modified = GETDATE()
        FROM inserted i
        INNER JOIN msdb.dbo.syspolicy_conditions_internal c ON i.condition_id = c.condition_id

    -- update health state table by deleting all the records for
    -- policies whose expression has been modified
    IF UPDATE(expression)
    BEGIN
        DELETE FROM dbo.syspolicy_system_health_state_internal
            FROM dbo.syspolicy_system_health_state_internal phs
            INNER JOIN dbo.syspolicy_policies p ON phs.policy_id = p.policy_id
            INNER JOIN inserted i ON p.condition_id = i.condition_id
            INNER JOIN deleted d ON p.condition_id = d.condition_id
            WHERE d.expression != i.expression
    END
END
GO
