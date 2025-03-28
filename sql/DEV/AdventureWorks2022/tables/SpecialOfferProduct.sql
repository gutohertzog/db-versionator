USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SpecialOfferProduct] (
    [SpecialOfferID] int NOT NULL -- PK FK [SpecialOffer]
    ,[ProductID] int NOT NULL -- PK FK [Product]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SpecialOfferProduct_SpecialOfferID_ProductID]
        PRIMARY KEY ([SpecialOfferID], [ProductID])

    ,CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Sales].[Product] ([ProductID])

    ,CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID]
        FOREIGN KEY ([SpecialOfferID])
        REFERENCES [Sales].[SpecialOffer] ([SpecialOfferID])
)
GO

ALTER TABLE [Sales].[SpecialOfferProduct] ADD CONSTRAINT [DF_SpecialOfferProduct_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SpecialOfferProduct] ADD CONSTRAINT [DF_SpecialOfferProduct_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
