USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_Person_LastName_FirstName_MiddleName] ON [Person].[Person]
(
    [LastName],
    [FirstName],
    [MiddleName]
)
GO
