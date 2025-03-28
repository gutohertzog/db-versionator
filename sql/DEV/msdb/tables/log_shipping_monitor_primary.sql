USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_monitor_primary] (
    [primary_id] uniqueidentifier NOT NULL -- PK
    ,[primary_server] sysname NOT NULL
    ,[primary_database] sysname NOT NULL
    ,[backup_threshold] int NOT NULL
    ,[threshold_alert] int NOT NULL
    ,[threshold_alert_enabled] bit NOT NULL
    ,[last_backup_file] nvarchar(500) NULL
    ,[last_backup_date] datetime NULL
    ,[last_backup_date_utc] datetime NULL
    ,[history_retention_period] int NOT NULL

    ,CONSTRAINT [PK__log_ship__ED3BE111F42E07F1]
        PRIMARY KEY ([primary_id])
)
GO
