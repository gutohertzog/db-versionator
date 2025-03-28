USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderHeader_SalesPersonID] ON [Sales].[SalesOrderHeader]
(
    [SalesPersonID]
)
GO
