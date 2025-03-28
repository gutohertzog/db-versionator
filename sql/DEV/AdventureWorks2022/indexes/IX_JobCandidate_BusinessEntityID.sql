USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_JobCandidate_BusinessEntityID] ON [HumanResources].[JobCandidate]
(
    [BusinessEntityID]
)
GO
