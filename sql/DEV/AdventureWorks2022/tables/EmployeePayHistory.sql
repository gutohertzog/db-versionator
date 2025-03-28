USE [AdventureWorks2022]
GO

CREATE TABLE [HumanResources].[EmployeePayHistory] (
    [BusinessEntityID] int NOT NULL -- PK FK [Employee]
    ,[RateChangeDate] datetime NOT NULL -- PK
    ,[Rate] money NOT NULL -- CK [>= 6.50 AND <= 200.00 ]
    ,[PayFrequency] tinyint NOT NULL -- CK [= 2 OR = 1 ]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_EmployeePayHistory_BusinessEntityID_RateChangeDate]
        PRIMARY KEY ([BusinessEntityID], [RateChangeDate])

    ,CONSTRAINT [FK_EmployeePayHistory_Employee_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [HumanResources].[Employee] ([BusinessEntityID])

    ,CONSTRAINT [CK_EmployeePayHistory_PayFrequency]
        CHECK (([PayFrequency]=(2) OR [PayFrequency]=(1)))

    ,CONSTRAINT [CK_EmployeePayHistory_Rate]
        CHECK (([Rate]>=(6.50) AND [Rate]<=(200.00)))
)
GO

ALTER TABLE [HumanResources].[EmployeePayHistory] ADD CONSTRAINT [DF_EmployeePayHistory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
