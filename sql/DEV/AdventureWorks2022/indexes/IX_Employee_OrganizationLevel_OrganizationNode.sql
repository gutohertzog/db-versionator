USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_Employee_OrganizationLevel_OrganizationNode] ON [HumanResources].[Employee]
(
    [OrganizationLevel],
    [OrganizationNode]
)
GO
