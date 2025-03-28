USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_Store_SalesPersonID] ON [Sales].[Store]
(
    [SalesPersonID]
)
GO
