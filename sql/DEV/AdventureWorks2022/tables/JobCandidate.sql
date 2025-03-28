USE [AdventureWorks2022]
GO

CREATE TABLE [HumanResources].[JobCandidate] (
    [JobCandidateID] int NOT NULL IDENTITY(1,1) -- PK
    ,[BusinessEntityID] int NULL -- FK [Employee]
    ,[Resume] xml NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_JobCandidate_JobCandidateID]
        PRIMARY KEY ([JobCandidateID])

    ,CONSTRAINT [FK_JobCandidate_Employee_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
)
GO

ALTER TABLE [HumanResources].[JobCandidate] ADD CONSTRAINT [DF_JobCandidate_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
