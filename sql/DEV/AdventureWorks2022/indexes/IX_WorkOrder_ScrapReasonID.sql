USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_WorkOrder_ScrapReasonID] ON [Production].[WorkOrder]
(
    [ScrapReasonID]
)
GO
