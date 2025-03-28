USE [AdventureWorks2022]
GO

CREATE XML INDEX [XMLVALUE_Person_Demographics] ON [Person].[Person]
(
    [Demographics]
)
GO
