USE [AdventureWorks2022]
GO

CREATE XML INDEX [PXML_Person_AddContact] ON [Person].[Person]
(
    [AdditionalContactInfo]
)
GO
