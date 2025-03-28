USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_ProductVendor_BusinessEntityID] ON [Purchasing].[ProductVendor]
(
    [BusinessEntityID]
)
GO
