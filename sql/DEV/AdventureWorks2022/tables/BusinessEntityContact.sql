USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[BusinessEntityContact] (
    [BusinessEntityID] int NOT NULL -- PK FK [BusinessEntity]
    ,[PersonID] int NOT NULL -- PK FK [Person]
    ,[ContactTypeID] int NOT NULL -- PK FK [ContactType]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID]
        PRIMARY KEY ([BusinessEntityID], [PersonID], [ContactTypeID])

    ,CONSTRAINT [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])

    ,CONSTRAINT [FK_BusinessEntityContact_ContactType_ContactTypeID]
        FOREIGN KEY ([ContactTypeID])
        REFERENCES [Person].[ContactType] ([ContactTypeID])

    ,CONSTRAINT [FK_BusinessEntityContact_Person_PersonID]
        FOREIGN KEY ([PersonID])
        REFERENCES [Person].[Person] ([BusinessEntityID])
)
GO

ALTER TABLE [Person].[BusinessEntityContact] ADD CONSTRAINT [DF_BusinessEntityContact_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[BusinessEntityContact] ADD CONSTRAINT [DF_BusinessEntityContact_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
