USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc1lssecondary] ON [dbo].[log_shipping_secondary]
(
    [monitor_server]
)
GO
