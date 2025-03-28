USE [msdb]
GO

CREATE CLUSTERED INDEX [c1lsmonitor_history_detail] ON [dbo].[log_shipping_monitor_history_detail]
(
    [agent_id],
    [agent_type]
)
GO
