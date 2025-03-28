USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc2lsmonitor_secondary] ON [dbo].[log_shipping_monitor_secondary]
(
    [restore_threshold]
)
GO
