USE [msdb]
GO

CREATE   VIEW [dbo].[syspolicy_policy_category_subscriptions]
AS
    SELECT
        policy_category_subscription_id,
        target_type,
        target_object,
        policy_category_id
    FROM [dbo].[syspolicy_policy_category_subscriptions_internal]
GO

GRANT SELECT ON [syspolicy_policy_category_subscriptions] TO [PolicyAdministratorRole]
GRANT SELECT ON [syspolicy_policy_category_subscriptions] TO [public]
GO
