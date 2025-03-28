USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_EmployeeDepartmentHistory_DepartmentID] ON [HumanResources].[EmployeeDepartmentHistory]
(
    [DepartmentID]
)
GO
