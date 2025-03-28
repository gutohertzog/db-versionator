USE [msdb]
GO

CREATE TABLE [dbo].[sysmanagement_shared_server_groups_internal] (
    [server_group_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[name] sysname NOT NULL -- UK
    ,[description] nvarchar(2048) NOT NULL
    ,[server_type] int NOT NULL
    ,[parent_id] int NULL -- UK
    ,[is_system_object] bit NULL -- DF [0]

    ,CONSTRAINT [PK__sysmanag__752ABCF9337C99BB]
        PRIMARY KEY ([server_group_id])

    ,CONSTRAINT [UQ_sysmanagement_unique_group_name_per_parent]
        UNIQUE CLUSTERED ([parent_id], [parent_id], [name])
)
GO

ALTER TABLE [dbo].[sysmanagement_shared_server_groups_internal] ADD CONSTRAINT [DF__sysmanage__is_sy__0F824689]
    DEFAULT (((0))) FOR [is_system_object]
GO
