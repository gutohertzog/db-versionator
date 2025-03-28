USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_WorkOrder_ProductID] ON [Production].[WorkOrder]
(
    [ProductID]
)
GO
