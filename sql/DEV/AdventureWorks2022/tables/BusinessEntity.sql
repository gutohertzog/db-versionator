USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[BusinessEntity] (
    [BusinessEntityID] int NOT NULL IDENTITY(1,1) -- PK
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_BusinessEntity_BusinessEntityID]
        PRIMARY KEY ([BusinessEntityID])
)
GO

ALTER TABLE [Person].[BusinessEntity] ADD CONSTRAINT [DF_BusinessEntity_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[BusinessEntity] ADD CONSTRAINT [DF_BusinessEntity_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
