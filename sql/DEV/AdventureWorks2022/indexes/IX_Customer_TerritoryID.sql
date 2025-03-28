USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_Customer_TerritoryID] ON [Sales].[Customer]
(
    [TerritoryID]
)
GO
