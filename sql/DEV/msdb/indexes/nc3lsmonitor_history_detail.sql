USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc3lsmonitor_history_detail] ON [dbo].[log_shipping_monitor_history_detail]
(
    [log_time_utc]
)
GO
