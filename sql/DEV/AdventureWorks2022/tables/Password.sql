USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[Password] (
    [BusinessEntityID] int NOT NULL -- PK FK [Person]
    ,[PasswordHash] varchar(128) NOT NULL
    ,[PasswordSalt] varchar(10) NOT NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Password_BusinessEntityID]
        PRIMARY KEY ([BusinessEntityID])

    ,CONSTRAINT [FK_Password_Person_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Person].[Person] ([BusinessEntityID])
)
GO

ALTER TABLE [Person].[Password] ADD CONSTRAINT [DF_Password_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[Password] ADD CONSTRAINT [DF_Password_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
