USE [msdb]
GO

CREATE TABLE [dbo].[syscollector_execution_log_internal] (
    [log_id] bigint NOT NULL IDENTITY(1,1) -- PK
    ,[parent_log_id] bigint NULL
    ,[collection_set_id] int NOT NULL -- FK [syscollector_collection_sets_internal]
    ,[collection_item_id] int NULL
    ,[start_time] datetime NOT NULL
    ,[last_iteration_time] datetime NULL
    ,[finish_time] datetime NULL
    ,[runtime_execution_mode] smallint NULL
    ,[status] smallint NOT NULL
    ,[operator] nvarchar(128) NOT NULL
    ,[package_id] uniqueidentifier NULL
    ,[package_execution_id] uniqueidentifier NULL
    ,[failure_message] nvarchar(2048) NULL

    ,CONSTRAINT [PK_syscollector_execution_log]
        PRIMARY KEY ([log_id])

    ,CONSTRAINT [FK_syscollector_execution_log_collection_set_id]
        FOREIGN KEY ([collection_set_id])
        REFERENCES [dbo].[syscollector_collection_sets_internal] ([collection_set_id])
)
GO
