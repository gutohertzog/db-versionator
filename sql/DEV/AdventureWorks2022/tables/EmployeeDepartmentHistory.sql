USE [AdventureWorks2022]
GO

CREATE TABLE [HumanResources].[EmployeeDepartmentHistory] (
    [BusinessEntityID] int NOT NULL -- PK FK [Employee]
    ,[DepartmentID] smallint NOT NULL -- PK FK [Department]
    ,[ShiftID] tinyint NOT NULL -- PK FK [Shift]
    ,[StartDate] date NOT NULL -- PK
    ,[EndDate] date NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID]
        PRIMARY KEY ([BusinessEntityID], [StartDate], [DepartmentID], [ShiftID])

    ,CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID]
        FOREIGN KEY ([DepartmentID])
        REFERENCES [HumanResources].[Department] ([DepartmentID])

    ,CONSTRAINT [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [HumanResources].[Employee] ([BusinessEntityID])

    ,CONSTRAINT [FK_EmployeeDepartmentHistory_Shift_ShiftID]
        FOREIGN KEY ([ShiftID])
        REFERENCES [HumanResources].[Shift] ([ShiftID])
)
GO

ALTER TABLE [HumanResources].[EmployeeDepartmentHistory] ADD CONSTRAINT [DF_EmployeeDepartmentHistory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
