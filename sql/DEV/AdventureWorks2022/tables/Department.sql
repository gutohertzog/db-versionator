USE [AdventureWorks2022]
GO

CREATE TABLE [HumanResources].[Department] (
    [DepartmentID] smallint NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[GroupName] Name NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Department_DepartmentID]
        PRIMARY KEY ([DepartmentID])
)
GO

ALTER TABLE [HumanResources].[Department] ADD CONSTRAINT [DF_Department_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
