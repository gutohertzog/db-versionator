USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[EmailAddress] (
    [BusinessEntityID] int NOT NULL -- PK FK [Person]
    ,[EmailAddressID] int NOT NULL IDENTITY(1,1) -- PK
    ,[EmailAddress] nvarchar(50) NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_EmailAddress_BusinessEntityID_EmailAddressID]
        PRIMARY KEY ([BusinessEntityID], [EmailAddressID])

    ,CONSTRAINT [FK_EmailAddress_Person_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Person].[Person] ([BusinessEntityID])
)
GO

ALTER TABLE [Person].[EmailAddress] ADD CONSTRAINT [DF_EmailAddress_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[EmailAddress] ADD CONSTRAINT [DF_EmailAddress_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
