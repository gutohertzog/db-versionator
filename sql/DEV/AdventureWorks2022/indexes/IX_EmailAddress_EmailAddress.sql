USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_EmailAddress_EmailAddress] ON [Person].[EmailAddress]
(
    [EmailAddress]
)
GO
