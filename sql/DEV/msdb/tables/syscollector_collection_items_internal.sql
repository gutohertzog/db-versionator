USE [msdb]
GO

CREATE TABLE [dbo].[syscollector_collection_items_internal] (
    [collection_set_id] int NOT NULL -- PK FK [syscollector_collection_sets_internal]
    ,[collection_item_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[collector_type_uid] uniqueidentifier NOT NULL -- FK [syscollector_collector_types_internal]
    ,[name] sysname NOT NULL -- UK
    ,[name_id] int NULL
    ,[frequency] int NOT NULL
    ,[parameters] xml NULL

    ,CONSTRAINT [PK_syscollector_collection_items_internal]
        PRIMARY KEY ([collection_set_id], [collection_item_id])

    ,CONSTRAINT [UQ_syscollector_collection_items_internal_name]
        UNIQUE CLUSTERED ([name], [name])

    ,CONSTRAINT [FK_syscollector_collection_items_internal_syscollector_collection_sets_internal]
        FOREIGN KEY ([collection_set_id])
        REFERENCES [dbo].[syscollector_collection_sets_internal] ([collection_set_id])

    ,CONSTRAINT [FK_syscollector_collection_items_internal_syscollector_collector_types_internal]
        FOREIGN KEY ([collector_type_uid])
        REFERENCES [dbo].[syscollector_collector_types_internal] ([collector_type_uid])
)
GO
