USE [msdb]
GO

CREATE   VIEW [dbo].[syspolicy_policy_execution_history]
AS
    SELECT
        history_id,
        policy_id,
        start_date,
        end_date,
        result,
        exception_message,
        exception
    FROM [dbo].[syspolicy_policy_execution_history_internal]
GO

GRANT SELECT ON [syspolicy_policy_execution_history] TO [PolicyAdministratorRole]
GRANT SELECT ON [syspolicy_policy_execution_history] TO [public]
GO
