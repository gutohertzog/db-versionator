USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_policy_category_subscriptions_internal] (
    [policy_category_subscription_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[target_type] sysname NOT NULL
    ,[target_object] sysname NOT NULL
    ,[policy_category_id] int NOT NULL -- FK [syspolicy_policy_categories_internal]

    ,CONSTRAINT [PK_syspolicy_policy_category_subscriptions]
        PRIMARY KEY ([policy_category_subscription_id])

    ,CONSTRAINT [FK_syspolicy_policy_category_subscriptions_syspolicy_policy_categories]
        FOREIGN KEY ([policy_category_id])
        REFERENCES [dbo].[syspolicy_policy_categories_internal] ([policy_category_id])
)
GO
