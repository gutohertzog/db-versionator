USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderHeader_CustomerID] ON [Sales].[SalesOrderHeader]
(
    [CustomerID]
)
GO
