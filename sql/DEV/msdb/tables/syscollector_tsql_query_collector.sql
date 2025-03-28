USE [msdb]
GO

CREATE TABLE [dbo].[syscollector_tsql_query_collector] (
    [collection_set_uid] uniqueidentifier NOT NULL
    ,[collection_set_id] int NOT NULL -- FK [syscollector_collection_items_internal]
    ,[collection_item_id] int NOT NULL -- FK [syscollector_collection_items_internal]
    ,[collection_package_id] uniqueidentifier NOT NULL
    ,[upload_package_id] uniqueidentifier NOT NULL

    ,CONSTRAINT [FK_syscollector_tsql_query_collector_syscollector_collection_items_internal]
        FOREIGN KEY ([collection_set_id], [collection_item_id])
        REFERENCES [dbo].[syscollector_collection_items_internal] ([collection_set_id], [collection_item_id])
)
GO
