USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_filegroups_with_policy_violations_internal] (
    [server_instance_name] sysname NOT NULL -- PK
    ,[database_name] sysname NOT NULL -- PK
    ,[filegroup_name] sysname NOT NULL -- PK
    ,[policy_id] int NOT NULL -- PK
    ,[set_number] int NOT NULL -- PK

    ,CONSTRAINT [PK_sysutility_ucp_filegroups_with_policy_violations_internal]
        PRIMARY KEY ([set_number], [policy_id], [server_instance_name], [database_name], [filegroup_name])
)
GO
