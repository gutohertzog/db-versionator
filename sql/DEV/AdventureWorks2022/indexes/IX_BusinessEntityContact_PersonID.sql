USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_BusinessEntityContact_PersonID] ON [Person].[BusinessEntityContact]
(
    [PersonID]
)
GO
