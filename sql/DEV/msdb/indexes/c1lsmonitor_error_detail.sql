USE [msdb]
GO

CREATE CLUSTERED INDEX [c1lsmonitor_error_detail] ON [dbo].[log_shipping_monitor_error_detail]
(
    [agent_id],
    [agent_type]
)
GO
