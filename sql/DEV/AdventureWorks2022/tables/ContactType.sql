USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[ContactType] (
    [ContactTypeID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ContactType_ContactTypeID]
        PRIMARY KEY ([ContactTypeID])
)
GO

ALTER TABLE [Person].[ContactType] ADD CONSTRAINT [DF_ContactType_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
