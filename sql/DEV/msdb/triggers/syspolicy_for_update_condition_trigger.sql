USE [msdb]
GO

CREATE   TRIGGER dbo.syspolicy_for_update_condition_trigger
ON msdb.dbo.syspolicy_conditions_internal
FOR UPDATE
AS
BEGIN
    -- do not allow expression to be changed to a script
    -- if the policy is enabled
    IF UPDATE(expression)
    BEGIN
        DECLARE @row_count int

        SELECT @row_count = count(*)
            FROM inserted i
            INNER JOIN syspolicy_policies p ON (i.condition_id = p.condition_id OR p.root_condition_id = i.condition_id)
            WHERE    p.is_enabled != 0 AND
                    p.execution_mode != 4 AND
                    (1 = CONVERT(xml, i.expression).exist('//FunctionType/text()[.="ExecuteSql"]' ) OR
                    1 = CONVERT(xml, i.expression).exist('//FunctionType/text()[.="ExecuteWql"]' ) )
            OPTION (FORCE ORDER)

        SELECT @row_count = @row_count + count(*)
            FROM dbo.syspolicy_target_set_levels l
            INNER JOIN dbo.syspolicy_target_sets s ON s.target_set_id = l.target_set_id
            INNER JOIN inserted i on i.condition_id = l.condition_id
            INNER JOIN syspolicy_object_sets_internal os ON s.object_set_id = os.object_set_id
            INNER JOIN syspolicy_policies p ON os.object_set_id = p.object_set_id
            WHERE    p.is_enabled != 0 AND
                    p.execution_mode != 4 AND
                    (1 = CONVERT(xml, i.expression).exist('//FunctionType/text()[.="ExecuteSql"]' ) OR
                    1 = CONVERT(xml, i.expression).exist('//FunctionType/text()[.="ExecuteWql"]' ) )
            OPTION (FORCE ORDER)

        IF (@row_count > 0)
        BEGIN
            RAISERROR(34017, -1, -1)
            ROLLBACK TRANSACTION
        END
    END

	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN;
	END

	-- This is to prevent indirect entrance of the trigger
	IF (TRIGGER_NESTLEVEL() > 1)
		RETURN
END
GO
