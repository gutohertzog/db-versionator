USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductProductPhoto] (
    [ProductID] int NOT NULL -- PK FK [Product]
    ,[ProductPhotoID] int NOT NULL -- PK FK [ProductPhoto]
    ,[Primary] Flag NOT NULL -- DF [0]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductProductPhoto_ProductID_ProductPhotoID]
        PRIMARY KEY ([ProductID], [ProductPhotoID])

    ,CONSTRAINT [FK_ProductProductPhoto_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Production].[Product] ([ProductID])

    ,CONSTRAINT [FK_ProductProductPhoto_ProductPhoto_ProductPhotoID]
        FOREIGN KEY ([ProductPhotoID])
        REFERENCES [Production].[ProductPhoto] ([ProductPhotoID])
)
GO

ALTER TABLE [Production].[ProductProductPhoto] ADD CONSTRAINT [DF_ProductProductPhoto_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[ProductProductPhoto] ADD CONSTRAINT [DF_ProductProductPhoto_Primary]
    DEFAULT (((0))) FOR [Primary]
GO
