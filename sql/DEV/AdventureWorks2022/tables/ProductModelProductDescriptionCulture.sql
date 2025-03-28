USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductModelProductDescriptionCulture] (
    [ProductModelID] int NOT NULL -- PK FK [ProductModel]
    ,[ProductDescriptionID] int NOT NULL -- PK FK [ProductDescription]
    ,[CultureID] nchar(12) NOT NULL -- PK FK [Culture]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID]
        PRIMARY KEY ([ProductModelID], [ProductDescriptionID], [CultureID])

    ,CONSTRAINT [FK_ProductModelProductDescriptionCulture_Culture_CultureID]
        FOREIGN KEY ([CultureID])
        REFERENCES [Production].[Culture] ([CultureID])

    ,CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID]
        FOREIGN KEY ([ProductDescriptionID])
        REFERENCES [Production].[ProductDescription] ([ProductDescriptionID])

    ,CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID]
        FOREIGN KEY ([ProductModelID])
        REFERENCES [Production].[ProductModel] ([ProductModelID])
)
GO

ALTER TABLE [Production].[ProductModelProductDescriptionCulture] ADD CONSTRAINT [DF_ProductModelProductDescriptionCulture_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
