USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_monitor_secondary] (
    [secondary_server] sysname NOT NULL
    ,[secondary_database] sysname NOT NULL -- PK
    ,[secondary_id] uniqueidentifier NOT NULL -- PK
    ,[primary_server] sysname NOT NULL
    ,[primary_database] sysname NOT NULL
    ,[restore_threshold] int NOT NULL
    ,[threshold_alert] int NOT NULL
    ,[threshold_alert_enabled] bit NOT NULL
    ,[last_copied_file] nvarchar(500) NULL
    ,[last_copied_date] datetime NULL
    ,[last_copied_date_utc] datetime NULL
    ,[last_restored_file] nvarchar(500) NULL
    ,[last_restored_date] datetime NULL
    ,[last_restored_date_utc] datetime NULL
    ,[last_restored_latency] int NULL
    ,[history_retention_period] int NOT NULL

    ,CONSTRAINT [pklsmonitor_secondary]
        PRIMARY KEY ([secondary_id], [secondary_database])
)
GO
