USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_TransactionHistoryArchive_ProductID] ON [Production].[TransactionHistoryArchive]
(
    [ProductID]
)
GO
