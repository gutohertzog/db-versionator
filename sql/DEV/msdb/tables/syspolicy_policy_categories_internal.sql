USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_policy_categories_internal] (
    [policy_category_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[name] sysname NOT NULL -- UK
    ,[mandate_database_subscriptions] bit NOT NULL -- DF [1]

    ,CONSTRAINT [PK_syspolicy_policy_categories]
        PRIMARY KEY ([policy_category_id])

    ,CONSTRAINT [UQ_syspolicy_policy_categories_name]
        UNIQUE CLUSTERED ([name], [name])
)
GO

ALTER TABLE [dbo].[syspolicy_policy_categories_internal] ADD CONSTRAINT [DF__syspolicy__manda__38845C1C]
    DEFAULT (((1))) FOR [mandate_database_subscriptions]
GO
