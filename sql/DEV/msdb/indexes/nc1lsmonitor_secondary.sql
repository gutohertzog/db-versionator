USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc1lsmonitor_secondary] ON [dbo].[log_shipping_monitor_secondary]
(
    [secondary_id]
)
GO
