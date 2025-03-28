USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_secondary_databases] (
    [secondary_database] sysname NOT NULL -- PK
    ,[secondary_id] uniqueidentifier NOT NULL
    ,[restore_delay] int NOT NULL
    ,[restore_all] bit NOT NULL
    ,[restore_mode] bit NOT NULL
    ,[disconnect_users] bit NOT NULL
    ,[block_size] int NULL
    ,[buffer_count] int NULL
    ,[max_transfer_size] int NULL
    ,[last_restored_file] nvarchar(500) NULL
    ,[last_restored_date] datetime NULL

    ,CONSTRAINT [PK__log_ship__093E1AB5E6C69B48]
        PRIMARY KEY ([secondary_database])
)
GO
