USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_primary_databases] (
    [primary_id] uniqueidentifier NOT NULL -- PK
    ,[primary_database] sysname NOT NULL -- UK
    ,[backup_directory] nvarchar(500) NOT NULL
    ,[backup_share] nvarchar(500) NOT NULL
    ,[backup_retention_period] int NOT NULL
    ,[backup_job_id] uniqueidentifier NOT NULL
    ,[monitor_server] sysname NOT NULL
    ,[user_specified_monitor] bit NULL
    ,[monitor_server_security_mode] bit NOT NULL
    ,[last_backup_file] nvarchar(500) NULL
    ,[last_backup_date] datetime NULL
    ,[backup_compression] tinyint NOT NULL -- DF [2]

    ,CONSTRAINT [PK__log_ship__ED3BE1111B19FE26]
        PRIMARY KEY ([primary_id])

    ,CONSTRAINT [UQ__log_ship__2A5EF6DC0FF36203]
        UNIQUE CLUSTERED ([primary_database], [primary_database])
)
GO

ALTER TABLE [dbo].[log_shipping_primary_databases] ADD CONSTRAINT [DF__log_shipp__backu__23A93AC7]
    DEFAULT (((2))) FOR [backup_compression]
GO
