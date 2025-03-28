USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_TransactionHistory_ProductID] ON [Production].[TransactionHistory]
(
    [ProductID]
)
GO
