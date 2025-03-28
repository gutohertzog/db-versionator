USE [AdventureWorks2022]
GO

CREATE TABLE [HumanResources].[Employee] (
    [BusinessEntityID] int NOT NULL -- PK FK [Person]
    ,[NationalIDNumber] nvarchar(15) NOT NULL
    ,[LoginID] nvarchar(256) NOT NULL
    ,[OrganizationNode] hierarchyid NULL
    ,[OrganizationLevel] smallint NULL
    ,[JobTitle] nvarchar(50) NOT NULL
    ,[BirthDate] date NOT NULL -- CK [>'1930-01-01' AND <=dateadd year, -18 ,getdate  ]
    ,[MaritalStatus] nchar(2) NOT NULL -- CK [upper 'S' OR upper 'M']
    ,[Gender] nchar(2) NOT NULL -- CK [upper 'F' OR upper 'M']
    ,[HireDate] date NOT NULL -- CK [>'1996-07-01' AND <=dateadd day, 1 ,getdate  ]
    ,[SalariedFlag] Flag NOT NULL -- DF [1]
    ,[VacationHours] smallint NOT NULL -- DF [0] CK [>= -40 AND <= 240 ]
    ,[SickLeaveHours] smallint NOT NULL -- DF [0] CK [>= 0 AND <= 120 ]
    ,[CurrentFlag] Flag NOT NULL -- DF [1]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Employee_BusinessEntityID]
        PRIMARY KEY ([BusinessEntityID])

    ,CONSTRAINT [FK_Employee_Person_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [HumanResources].[Person] ([BusinessEntityID])

    ,CONSTRAINT [CK_Employee_BirthDate]
        CHECK (([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate())))

    ,CONSTRAINT [CK_Employee_Gender]
        CHECK ((upper([Gender])='F' OR upper([Gender])='M'))

    ,CONSTRAINT [CK_Employee_HireDate]
        CHECK (([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate())))

    ,CONSTRAINT [CK_Employee_MaritalStatus]
        CHECK ((upper([MaritalStatus])='S' OR upper([MaritalStatus])='M'))

    ,CONSTRAINT [CK_Employee_SickLeaveHours]
        CHECK (([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120)))

    ,CONSTRAINT [CK_Employee_VacationHours]
        CHECK (([VacationHours]>=(-40) AND [VacationHours]<=(240)))
)
GO

ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [DF_Employee_CurrentFlag]
    DEFAULT (((1))) FOR [CurrentFlag]
GO

ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [DF_Employee_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [DF_Employee_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO

ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [DF_Employee_SalariedFlag]
    DEFAULT (((1))) FOR [SalariedFlag]
GO

ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [DF_Employee_SickLeaveHours]
    DEFAULT (((0))) FOR [SickLeaveHours]
GO

ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [DF_Employee_VacationHours]
    DEFAULT (((0))) FOR [VacationHours]
GO
