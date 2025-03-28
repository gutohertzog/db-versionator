USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_CountryRegionCurrency_CurrencyCode] ON [Sales].[CountryRegionCurrency]
(
    [CurrencyCode]
)
GO
