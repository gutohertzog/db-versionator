USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_primaries] (
    [primary_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[primary_server_name] sysname NOT NULL
    ,[primary_database_name] sysname NOT NULL
    ,[maintenance_plan_id] uniqueidentifier NULL
    ,[backup_threshold] int NOT NULL
    ,[threshold_alert] int NOT NULL
    ,[threshold_alert_enabled] bit NOT NULL
    ,[last_backup_filename] nvarchar(500) NULL
    ,[last_updated] datetime NULL
    ,[planned_outage_start_time] int NOT NULL
    ,[planned_outage_end_time] int NOT NULL
    ,[planned_outage_weekday_mask] int NOT NULL
    ,[source_directory] nvarchar(500) NULL

    ,CONSTRAINT [PK__log_ship__ED3BE111B0B75C08]
        PRIMARY KEY ([primary_id])
)
GO
