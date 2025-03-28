USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_primary_secondaries] (
    [primary_id] uniqueidentifier NOT NULL -- PK
    ,[secondary_server] sysname NOT NULL -- PK
    ,[secondary_database] sysname NOT NULL -- PK

    ,CONSTRAINT [pklsprimary_secondaries]
        PRIMARY KEY ([primary_id], [secondary_server], [secondary_database])
)
GO
