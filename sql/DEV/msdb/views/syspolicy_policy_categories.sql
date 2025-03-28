USE [msdb]
GO

CREATE   VIEW [dbo].[syspolicy_policy_categories]
AS
    SELECT
        policy_category_id,
        name,
        mandate_database_subscriptions
    FROM [dbo].[syspolicy_policy_categories_internal]
GO

GRANT SELECT ON [syspolicy_policy_categories] TO [PolicyAdministratorRole]
GRANT SELECT ON [syspolicy_policy_categories] TO [public]
GO
