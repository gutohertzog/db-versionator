USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductCategory] (
    [ProductCategoryID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductCategory_ProductCategoryID]
        PRIMARY KEY ([ProductCategoryID])
)
GO

ALTER TABLE [Production].[ProductCategory] ADD CONSTRAINT [DF_ProductCategory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[ProductCategory] ADD CONSTRAINT [DF_ProductCategory_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
