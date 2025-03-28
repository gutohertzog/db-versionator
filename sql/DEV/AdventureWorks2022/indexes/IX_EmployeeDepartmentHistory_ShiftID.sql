USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_EmployeeDepartmentHistory_ShiftID] ON [HumanResources].[EmployeeDepartmentHistory]
(
    [ShiftID]
)
GO
