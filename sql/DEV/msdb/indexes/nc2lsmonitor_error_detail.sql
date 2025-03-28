USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc2lsmonitor_error_detail] ON [dbo].[log_shipping_monitor_error_detail]
(
    [database_name]
)
GO
