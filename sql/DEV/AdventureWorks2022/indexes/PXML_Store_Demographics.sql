USE [AdventureWorks2022]
GO

CREATE XML INDEX [PXML_Store_Demographics] ON [Sales].[Store]
(
    [Demographics]
)
GO
