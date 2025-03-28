USE [AdventureWorks2022]
GO

CREATE XML INDEX [PXML_ProductModel_CatalogDescription] ON [Production].[ProductModel]
(
    [CatalogDescription]
)
GO
