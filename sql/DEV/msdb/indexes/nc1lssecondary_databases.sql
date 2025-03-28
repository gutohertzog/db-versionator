USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc1lssecondary_databases] ON [dbo].[log_shipping_secondary_databases]
(
    [secondary_id]
)
GO
