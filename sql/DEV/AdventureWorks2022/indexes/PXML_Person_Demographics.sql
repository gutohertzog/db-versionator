USE [AdventureWorks2022]
GO

CREATE XML INDEX [PXML_Person_Demographics] ON [Person].[Person]
(
    [Demographics]
)
GO
