USE [AdventureWorks2022]
GO

CREATE XML INDEX [PXML_ProductModel_Instructions] ON [Production].[ProductModel]
(
    [Instructions]
)
GO
