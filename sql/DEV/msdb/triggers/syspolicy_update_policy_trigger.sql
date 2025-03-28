USE [msdb]
GO

CREATE   TRIGGER [dbo].[syspolicy_update_policy_trigger] on [dbo].[syspolicy_policies_internal]
FOR UPDATE
AS
BEGIN
    -- Protect against non-scheduled enabled policies that have scripts in their conditions
    IF( UPDATE(is_enabled) )
    BEGIN
        DECLARE @row_count int

        SELECT @row_count = count(*)
            FROM syspolicy_conditions c
            INNER JOIN inserted i ON (i.condition_id = c.condition_id OR i.root_condition_id = c.condition_id)
            WHERE    i.is_enabled != 0 AND
                    i.execution_mode != 4 AND
                    (1 = CONVERT(xml, c.expression).exist('//FunctionType/text()[.="ExecuteSql"]' ) OR
                    1 = CONVERT(xml, c.expression).exist('//FunctionType/text()[.="ExecuteWql"]' ) )
            OPTION (FORCE ORDER)

        SELECT @row_count = @row_count + count(*)
            FROM dbo.syspolicy_target_set_levels l
            INNER JOIN dbo.syspolicy_target_sets s ON s.target_set_id = l.target_set_id
            INNER JOIN syspolicy_conditions c on c.condition_id = l.condition_id
            INNER JOIN syspolicy_object_sets_internal os on os.object_set_id = s.object_set_id
            INNER JOIN inserted i ON os.object_set_id = i.object_set_id
            WHERE    i.is_enabled != 0 AND
                    i.execution_mode != 4 AND
                    (1 = CONVERT(xml, c.expression).exist('//FunctionType/text()[.="ExecuteSql"]' ) OR
                    1 = CONVERT(xml, c.expression).exist('//FunctionType/text()[.="ExecuteWql"]' ) )
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

	-- This is to prevent indirect execution of the trigger
	IF (TRIGGER_NESTLEVEL() > 1) RETURN

    IF( UPDATE(condition_id) )
    BEGIN
        -- delete all health state records for active policies whose
        -- condition has changed
        DELETE FROM [dbo].[syspolicy_system_health_state_internal]
            FROM [dbo].[syspolicy_system_health_state_internal] phs
            INNER JOIN inserted i ON phs.policy_id = i.policy_id
            INNER JOIN deleted d ON phs.policy_id = d.policy_id
            WHERE d.condition_id != i.condition_id AND i.is_enabled = 1
    END

    IF( UPDATE(object_set_id) )
    BEGIN
        DECLARE @object_set_id int, @numref int, @new_object_set_id int, @name sysname

        DECLARE os_cursor CURSOR LOCAL FOR
        SELECT i.object_set_id, d.object_set_id, i.name
        FROM inserted i INNER JOIN deleted d ON (i.policy_id = d.policy_id)
        WHERE (d.object_set_id IS NOT NULL AND i.object_set_id IS NULL)
			OR (i.object_set_id IS NOT NULL AND d.object_set_id IS NULL)
			OR (d.object_set_id != i.object_set_id)

        OPEN os_cursor
        FETCH os_cursor INTO @new_object_set_id, @object_set_id, @name

        WHILE @@FETCH_STATUS = 0
        BEGIN
			IF (@object_set_id IS NOT NULL)
			BEGIN
				EXEC sp_syspolicy_verify_object_set_references @object_set_id, @numref OUTPUT
				IF (@numref = 0)
					EXEC sp_syspolicy_delete_object_set @object_set_id=@object_set_id
            END

			IF (@new_object_set_id IS NOT NULL)
			BEGIN
				EXEC sp_syspolicy_verify_object_set_references @new_object_set_id, @numref OUTPUT
				IF (@numref > 1)
				BEGIN
					DECLARE @os_name sysname, @policy_name sysname
					SELECT TOP 1 @os_name = os.object_set_name, @policy_name = p.name
					 FROM syspolicy_object_sets os
						INNER JOIN syspolicy_policies p ON (os.object_set_id = p.object_set_id)
					WHERE os.object_set_id = @object_set_id AND p.name <> @name

					RAISERROR(34013, -1, -1, 'ObjectSet', @os_name, @policy_name)
					ROLLBACK TRANSACTION
				END
            END

            FETCH os_cursor INTO @new_object_set_id, @object_set_id, @name
        END

        CLOSE os_cursor
        DEALLOCATE os_cursor

    END

    IF( UPDATE(is_enabled) )
    BEGIN
        -- delete all health state records for policies that
        -- have been disabled
        DELETE FROM [dbo].[syspolicy_system_health_state_internal]
            FROM [dbo].[syspolicy_system_health_state_internal] phs
            INNER JOIN inserted i ON phs.policy_id = i.policy_id
            INNER JOIN deleted d ON phs.policy_id = d.policy_id
            WHERE d.is_enabled = 1 AND i.is_enabled = 0
    END

END
GO
