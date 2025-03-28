USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_BusinessEntityContact_ContactTypeID] ON [Person].[BusinessEntityContact]
(
    [ContactTypeID]
)
GO
