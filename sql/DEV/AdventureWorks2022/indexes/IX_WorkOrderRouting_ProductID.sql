USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_WorkOrderRouting_ProductID] ON [Production].[WorkOrderRouting]
(
    [ProductID]
)
GO
