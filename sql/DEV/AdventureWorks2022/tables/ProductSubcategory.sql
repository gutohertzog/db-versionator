USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductSubcategory] (
    [ProductSubcategoryID] int NOT NULL IDENTITY(1,1) -- PK
    ,[ProductCategoryID] int NOT NULL -- FK [ProductCategory]
    ,[Name] Name NOT NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryID]
        PRIMARY KEY ([ProductSubcategoryID])

    ,CONSTRAINT [FK_ProductSubcategory_ProductCategory_ProductCategoryID]
        FOREIGN KEY ([ProductCategoryID])
        REFERENCES [Production].[ProductCategory] ([ProductCategoryID])
)
GO

ALTER TABLE [Production].[ProductSubcategory] ADD CONSTRAINT [DF_ProductSubcategory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[ProductSubcategory] ADD CONSTRAINT [DF_ProductSubcategory_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
