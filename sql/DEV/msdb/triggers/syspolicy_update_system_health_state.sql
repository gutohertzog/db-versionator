USE [msdb]
GO

CREATE   TRIGGER [syspolicy_update_system_health_state] ON [dbo].[syspolicy_policy_execution_history_internal]
AFTER UPDATE
AS
BEGIN
	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN;
	END

    -- if the entire policy has been checked delete all entries
    -- regarding that policy
    DELETE FROM [dbo].[syspolicy_system_health_state_internal]
        WHERE policy_id in (SELECT policy_id FROM inserted WHERE is_full_run = 1)

    -- Note: in the queries below new records are added only for
    -- policies that are enabled for automation

    -- if the policy is evaluated against a single target
    -- delete the old entry
    DELETE FROM [dbo].[syspolicy_system_health_state_internal]
        WHERE policy_id in
            (SELECT i.policy_id FROM inserted i WHERE i.is_full_run = 0) AND
                target_query_expression_with_id in (SELECT target_query_expression_with_id
                                                    FROM [dbo].[syspolicy_policy_execution_history_details_internal] d
                                                    INNER JOIN inserted i2 ON i2.history_id = d.history_id
                                                    WHERE i2.is_full_run = 0)


    -- insert the detail rows, but only for failures
    -- this is done both for the full runs and for the partial runs
    -- we will not insert anything if this is a ghost record, i.e.
    -- target_query_expression_with_id is null
    -- this will happen when we log prevent policies
    INSERT INTO [dbo].[syspolicy_system_health_state_internal]
        (policy_id, last_run_date, target_query_expression_with_id, target_query_expression, result)
    SELECT i.policy_id, d.execution_date, d.target_query_expression_with_id, d.target_query_expression, d.result
        FROM inserted i
        INNER JOIN [dbo].[syspolicy_policy_execution_history_details_internal] d on i.history_id = d.history_id
        INNER JOIN [dbo].[syspolicy_policies] p on i.policy_id = p.policy_id
        WHERE d.result = 0 AND p.is_enabled = 1 AND d.target_query_expression_with_id != N''

    -- delete all the success detail rows with no expression
    -- these are rows inserted so that we can update the system health state
    -- make an exception if the global switch says we should keep those records
    IF( 0 = (SELECT ISNULL(convert(bit, current_value), 0) FROM msdb.dbo.syspolicy_configuration WHERE name = 'LogOnSuccess'))
    BEGIN
        DELETE FROM d
        FROM [dbo].[syspolicy_policy_execution_history_details_internal] d
        INNER JOIN inserted i ON i.history_id = d.history_id
            WHERE d.result_detail = N''
    END
END
GO
