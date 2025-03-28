USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_BusinessEntityAddress_AddressTypeID] ON [Person].[BusinessEntityAddress]
(
    [AddressTypeID]
)
GO
