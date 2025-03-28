USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_PurchaseOrderHeader_EmployeeID] ON [Purchasing].[PurchaseOrderHeader]
(
    [EmployeeID]
)
GO
