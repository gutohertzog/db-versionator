USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_BusinessEntityAddress_AddressID] ON [Person].[BusinessEntityAddress]
(
    [AddressID]
)
GO
