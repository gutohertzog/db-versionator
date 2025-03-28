USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_SpecialOfferProduct_ProductID] ON [Sales].[SpecialOfferProduct]
(
    [ProductID]
)
GO
