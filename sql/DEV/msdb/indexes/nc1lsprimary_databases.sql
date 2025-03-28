USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc1lsprimary_databases] ON [dbo].[log_shipping_primary_databases]
(
    [monitor_server]
)
GO
