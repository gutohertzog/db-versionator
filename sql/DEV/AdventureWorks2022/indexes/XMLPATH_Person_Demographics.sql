USE [AdventureWorks2022]
GO

CREATE XML INDEX [XMLPATH_Person_Demographics] ON [Person].[Person]
(
    [Demographics]
)
GO
