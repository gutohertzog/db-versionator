USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc3lsmonitor_error_detail] ON [dbo].[log_shipping_monitor_error_detail]
(
    [log_time_utc]
)
GO
