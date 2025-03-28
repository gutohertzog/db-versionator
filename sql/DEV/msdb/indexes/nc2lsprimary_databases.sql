USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc2lsprimary_databases] ON [dbo].[log_shipping_primary_databases]
(
    [user_specified_monitor]
)
GO
