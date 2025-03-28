USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_policy_execution_history_details_internal] (
    [detail_id] bigint NOT NULL IDENTITY(1,1) -- PK
    ,[history_id] bigint NOT NULL -- PK FK [syspolicy_policy_execution_history_internal]
    ,[target_query_expression] nvarchar(4000) NOT NULL
    ,[target_query_expression_with_id] nvarchar(4000) NOT NULL
    ,[execution_date] datetime NOT NULL -- DF [getdate()]
    ,[result] bit NOT NULL
    ,[result_detail] nvarchar(MAX) NULL
    ,[exception_message] nvarchar(MAX) NULL
    ,[exception] nvarchar(MAX) NULL

    ,CONSTRAINT [PK_syspolicy_policy_execution_history_details_id]
        PRIMARY KEY ([history_id], [detail_id])

    ,CONSTRAINT [FK__syspolicy__histo__113584D1]
        FOREIGN KEY ([history_id])
        REFERENCES [dbo].[syspolicy_policy_execution_history_internal] ([history_id])
)
GO

ALTER TABLE [dbo].[syspolicy_policy_execution_history_details_internal] ADD CONSTRAINT [DF__syspolicy__execu__1229A90A]
    DEFAULT ((getdate())) FOR [execution_date]
GO
