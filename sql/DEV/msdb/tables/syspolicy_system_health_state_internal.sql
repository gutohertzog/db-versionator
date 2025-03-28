USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_system_health_state_internal] (
    [health_state_id] bigint NOT NULL IDENTITY(1,1) -- PK
    ,[policy_id] int NOT NULL -- FK [syspolicy_policies_internal]
    ,[last_run_date] datetime NOT NULL
    ,[target_query_expression_with_id] nvarchar(400) NOT NULL
    ,[target_query_expression] nvarchar(MAX) NOT NULL
    ,[result] bit NOT NULL

    ,CONSTRAINT [PK__syspolic__409BC9E5E4638B13]
        PRIMARY KEY ([health_state_id])

    ,CONSTRAINT [FK__syspolicy__polic__05C3D225]
        FOREIGN KEY ([policy_id])
        REFERENCES [dbo].[syspolicy_policies_internal] ([policy_id])
)
GO
