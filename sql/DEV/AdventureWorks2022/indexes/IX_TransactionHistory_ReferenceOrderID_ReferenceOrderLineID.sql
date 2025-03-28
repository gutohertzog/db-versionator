USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistory]
(
    [ReferenceOrderID],
    [ReferenceOrderLineID]
)
GO
