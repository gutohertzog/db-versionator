USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_PurchaseOrderHeader_VendorID] ON [Purchasing].[PurchaseOrderHeader]
(
    [VendorID]
)
GO
