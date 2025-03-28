USE [msdb]
GO

CREATE   VIEW [dbo].[syspolicy_policy_execution_history_details]
AS
    SELECT
        detail_id,
        history_id,
        target_query_expression,
        execution_date,
        result,
        result_detail,
        exception_message,
        exception
    FROM [dbo].[syspolicy_policy_execution_history_details_internal]
GO

GRANT SELECT ON [syspolicy_policy_execution_history_details] TO [PolicyAdministratorRole]
GRANT SELECT ON [syspolicy_policy_execution_history_details] TO [public]
GO
