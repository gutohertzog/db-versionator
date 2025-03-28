USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_PurchaseOrderDetail_ProductID] ON [Purchasing].[PurchaseOrderDetail]
(
    [ProductID]
)
GO
