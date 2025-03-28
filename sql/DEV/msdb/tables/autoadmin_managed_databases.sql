USE [msdb]
GO

CREATE TABLE [dbo].[autoadmin_managed_databases] (
    [autoadmin_id] bigint NOT NULL IDENTITY(1,1) -- PK UK
    ,[db_name] nvarchar(128) NOT NULL -- PK
    ,[db_id] int NOT NULL -- PK
    ,[db_guid] uniqueidentifier NOT NULL -- PK
    ,[group_db_guid] uniqueidentifier NULL
    ,[drop_date] datetime NULL

    ,CONSTRAINT [autoadmin_managed_databases_pk]
        PRIMARY KEY ([db_name], [db_id], [db_guid], [autoadmin_id])

    ,CONSTRAINT [UQ__autoadmi__627BCE60B8DB66E6]
        UNIQUE CLUSTERED ([autoadmin_id], [autoadmin_id])
)
GO
