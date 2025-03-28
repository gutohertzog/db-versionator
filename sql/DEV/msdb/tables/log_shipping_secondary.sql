USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_secondary] (
    [secondary_id] uniqueidentifier NOT NULL -- PK
    ,[primary_server] sysname NOT NULL
    ,[primary_database] sysname NOT NULL
    ,[backup_source_directory] nvarchar(500) NOT NULL
    ,[backup_destination_directory] nvarchar(500) NOT NULL
    ,[file_retention_period] int NOT NULL
    ,[copy_job_id] uniqueidentifier NOT NULL
    ,[restore_job_id] uniqueidentifier NOT NULL
    ,[monitor_server] sysname NOT NULL
    ,[monitor_server_security_mode] bit NOT NULL
    ,[user_specified_monitor] bit NULL
    ,[last_copied_file] nvarchar(500) NULL
    ,[last_copied_date] datetime NULL

    ,CONSTRAINT [PK__log_ship__DB57D5B2D21676E6]
        PRIMARY KEY ([secondary_id])
)
GO
