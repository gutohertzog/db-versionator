USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_monitor_alert] (
    [alert_job_id] uniqueidentifier NOT NULL -- PK

    ,CONSTRAINT [PK__log_ship__BD57EA576FCE9912]
        PRIMARY KEY ([alert_job_id])
)
GO
