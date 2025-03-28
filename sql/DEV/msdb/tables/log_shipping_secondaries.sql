USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_secondaries] (
    [primary_id] int NULL -- FK [log_shipping_primaries]
    ,[secondary_server_name] sysname NOT NULL
    ,[secondary_database_name] sysname NOT NULL
    ,[last_copied_filename] nvarchar(500) NULL
    ,[last_loaded_filename] nvarchar(500) NULL
    ,[last_copied_last_updated] datetime NULL
    ,[last_loaded_last_updated] datetime NULL
    ,[secondary_plan_id] uniqueidentifier NULL
    ,[copy_enabled] bit NULL
    ,[load_enabled] bit NULL
    ,[out_of_sync_threshold] int NULL
    ,[threshold_alert] int NULL
    ,[threshold_alert_enabled] bit NULL
    ,[planned_outage_start_time] int NULL
    ,[planned_outage_end_time] int NULL
    ,[planned_outage_weekday_mask] int NULL
    ,[allow_role_change] bit NULL -- DF [0]

    ,CONSTRAINT [FK__log_shipp__prima__7CA47C3F]
        FOREIGN KEY ([primary_id])
        REFERENCES [dbo].[log_shipping_primaries] ([primary_id])
)
GO

ALTER TABLE [dbo].[log_shipping_secondaries] ADD CONSTRAINT [DF__log_shipp__allow__7D98A078]
    DEFAULT (((0))) FOR [allow_role_change]
GO
