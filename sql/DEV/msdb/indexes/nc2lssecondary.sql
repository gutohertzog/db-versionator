USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc2lssecondary] ON [dbo].[log_shipping_secondary]
(
    [user_specified_monitor]
)
GO
