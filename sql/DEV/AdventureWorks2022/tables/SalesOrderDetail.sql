USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SalesOrderDetail] (
    [SalesOrderID] int NOT NULL -- PK FK [SalesOrderHeader]
    ,[SalesOrderDetailID] int NOT NULL IDENTITY(1,1) -- PK
    ,[CarrierTrackingNumber] nvarchar(25) NULL
    ,[OrderQty] smallint NOT NULL -- CK [> 0 ]
    ,[ProductID] int NOT NULL -- FK [SpecialOfferProduct]
    ,[SpecialOfferID] int NOT NULL -- FK [SpecialOfferProduct]
    ,[UnitPrice] money NOT NULL -- CK [>= 0.00 ]
    ,[UnitPriceDiscount] money NOT NULL -- DF [0.0] CK [>= 0.00 ]
    ,[LineTotal] numeric(38, 6) NOT NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID]
        PRIMARY KEY ([SalesOrderID], [SalesOrderDetailID])

    ,CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID]
        FOREIGN KEY ([SalesOrderID])
        REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID])

    ,CONSTRAINT [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID]
        FOREIGN KEY ([SpecialOfferID], [ProductID])
        REFERENCES [Sales].[SpecialOfferProduct] ([SpecialOfferID], [ProductID])

    ,CONSTRAINT [CK_SalesOrderDetail_OrderQty]
        CHECK (([OrderQty]>(0)))

    ,CONSTRAINT [CK_SalesOrderDetail_UnitPrice]
        CHECK (([UnitPrice]>=(0.00)))

    ,CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount]
        CHECK (([UnitPriceDiscount]>=(0.00)))
)
GO

ALTER TABLE [Sales].[SalesOrderDetail] ADD CONSTRAINT [DF_SalesOrderDetail_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SalesOrderDetail] ADD CONSTRAINT [DF_SalesOrderDetail_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO

ALTER TABLE [Sales].[SalesOrderDetail] ADD CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount]
    DEFAULT (((0.0))) FOR [UnitPriceDiscount]
GO
