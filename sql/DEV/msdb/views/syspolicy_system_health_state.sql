USE [msdb]
GO

CREATE   VIEW [dbo].[syspolicy_system_health_state]
AS
    SELECT
        health_state_id,
        policy_id,
        last_run_date,
        target_query_expression_with_id,
        target_query_expression,
        result
    FROM [dbo].[syspolicy_system_health_state_internal]
GO

GRANT SELECT ON [syspolicy_system_health_state] TO [PolicyAdministratorRole]
GRANT SELECT ON [syspolicy_system_health_state] TO [public]
GO
