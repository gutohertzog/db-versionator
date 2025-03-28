USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc3lsmonitor_secondary] ON [dbo].[log_shipping_monitor_secondary]
(
    [last_restored_latency]
)
GO
