USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail]
(
    [ProductID]
)
GO
