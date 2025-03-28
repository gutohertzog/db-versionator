USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc1lsprimary_secondaries] ON [dbo].[log_shipping_primary_secondaries]
(
    [primary_id]
)
GO
