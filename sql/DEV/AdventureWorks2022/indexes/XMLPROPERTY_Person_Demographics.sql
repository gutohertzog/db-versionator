USE [AdventureWorks2022]
GO

CREATE XML INDEX [XMLPROPERTY_Person_Demographics] ON [Person].[Person]
(
    [Demographics]
)
GO
