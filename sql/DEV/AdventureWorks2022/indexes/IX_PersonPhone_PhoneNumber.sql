USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_PersonPhone_PhoneNumber] ON [Person].[PersonPhone]
(
    [PhoneNumber]
)
GO
