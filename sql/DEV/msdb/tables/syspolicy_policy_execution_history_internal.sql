USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_policy_execution_history_internal] (
    [history_id] bigint NOT NULL IDENTITY(1,1) -- PK
    ,[policy_id] int NOT NULL -- FK [syspolicy_policies_internal]
    ,[start_date] datetime NOT NULL -- DF [getdate()]
    ,[end_date] datetime NULL
    ,[result] bit NOT NULL -- DF [0]
    ,[is_full_run] bit NOT NULL -- DF [1]
    ,[exception_message] nvarchar(MAX) NULL
    ,[exception] nvarchar(MAX) NULL

    ,CONSTRAINT [PK__syspolic__096AA2E9507B5EF8]
        PRIMARY KEY ([history_id])

    ,CONSTRAINT [FK__syspolicy__polic__09946309]
        FOREIGN KEY ([policy_id])
        REFERENCES [dbo].[syspolicy_policies_internal] ([policy_id])
)
GO

ALTER TABLE [dbo].[syspolicy_policy_execution_history_internal] ADD CONSTRAINT [DF__syspolicy__is_fu__0C70CFB4]
    DEFAULT (((1))) FOR [is_full_run]
GO

ALTER TABLE [dbo].[syspolicy_policy_execution_history_internal] ADD CONSTRAINT [DF__syspolicy__resul__0B7CAB7B]
    DEFAULT (((0))) FOR [result]
GO

ALTER TABLE [dbo].[syspolicy_policy_execution_history_internal] ADD CONSTRAINT [DF__syspolicy__start__0A888742]
    DEFAULT ((getdate())) FOR [start_date]
GO
