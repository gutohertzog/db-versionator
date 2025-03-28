USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_Employee_OrganizationNode] ON [HumanResources].[Employee]
(
    [OrganizationNode]
)
GO
