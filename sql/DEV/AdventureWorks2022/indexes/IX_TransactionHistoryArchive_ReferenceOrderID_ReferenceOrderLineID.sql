USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistoryArchive]
(
    [ReferenceOrderID],
    [ReferenceOrderLineID]
)
GO
