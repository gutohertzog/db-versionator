USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_ProductVendor_UnitMeasureCode] ON [Purchasing].[ProductVendor]
(
    [UnitMeasureCode]
)
GO
