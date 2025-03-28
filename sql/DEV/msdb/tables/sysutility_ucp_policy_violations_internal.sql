USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_policy_violations_internal] (
    [health_policy_id] int NOT NULL
    ,[policy_id] int NOT NULL -- PK
    ,[policy_name] sysname NULL
    ,[history_id] int NOT NULL -- PK
    ,[detail_id] int NOT NULL -- PK
    ,[target_query_expression] nvarchar(MAX) NULL
    ,[target_query_expression_with_id] nvarchar(MAX) NULL
    ,[execution_date] datetime NULL
    ,[result] int NULL

    ,CONSTRAINT [PK_sysutility_ucp_policy_violations_internal]
        PRIMARY KEY ([policy_id], [history_id], [detail_id])
)
GO
