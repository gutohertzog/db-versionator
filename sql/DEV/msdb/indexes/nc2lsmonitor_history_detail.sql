USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc2lsmonitor_history_detail] ON [dbo].[log_shipping_monitor_history_detail]
(
    [database_name]
)
GO
