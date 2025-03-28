USE [msdb]
GO

CREATE TABLE [dbo].[sysmanagement_shared_registered_servers_internal] (
    [server_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[server_group_id] int NULL -- UK FK [sysmanagement_shared_server_groups_internal]
    ,[name] sysname NOT NULL -- UK
    ,[server_name] sysname NOT NULL
    ,[description] nvarchar(2048) NOT NULL
    ,[server_type] int NOT NULL

    ,CONSTRAINT [PK__sysmanag__ED5B5C599C5F92E8]
        PRIMARY KEY ([server_id])

    ,CONSTRAINT [UQ_sysmanagement_unique_server_name_per_group]
        UNIQUE CLUSTERED ([server_group_id], [server_group_id], [name])

    ,CONSTRAINT [FK__sysmanage__serve__1446FBA6]
        FOREIGN KEY ([server_group_id])
        REFERENCES [dbo].[sysmanagement_shared_server_groups_internal] ([server_group_id])
)
GO
