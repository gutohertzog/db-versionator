USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductModel] (
    [ProductModelID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[CatalogDescription] xml NULL
    ,[Instructions] xml NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductModel_ProductModelID]
        PRIMARY KEY ([ProductModelID])
)
GO

ALTER TABLE [Production].[ProductModel] ADD CONSTRAINT [DF_ProductModel_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[ProductModel] ADD CONSTRAINT [DF_ProductModel_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
