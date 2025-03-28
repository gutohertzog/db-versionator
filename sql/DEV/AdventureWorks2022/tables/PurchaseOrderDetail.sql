USE [AdventureWorks2022]
GO

CREATE TABLE [Purchasing].[PurchaseOrderDetail] (
    [PurchaseOrderID] int NOT NULL -- PK FK [PurchaseOrderHeader]
    ,[PurchaseOrderDetailID] int NOT NULL IDENTITY(1,1) -- PK
    ,[DueDate] datetime NOT NULL
    ,[OrderQty] smallint NOT NULL -- CK [> 0 ]
    ,[ProductID] int NOT NULL -- FK [Product]
    ,[UnitPrice] money NOT NULL -- CK [>= 0.00 ]
    ,[LineTotal] money NOT NULL
    ,[ReceivedQty] decimal(8, 2) NOT NULL -- CK [>= 0.00 ]
    ,[RejectedQty] decimal(8, 2) NOT NULL -- CK [>= 0.00 ]
    ,[StockedQty] decimal(9, 2) NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID]
        PRIMARY KEY ([PurchaseOrderID], [PurchaseOrderDetailID])

    ,CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Purchasing].[Product] ([ProductID])

    ,CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID]
        FOREIGN KEY ([PurchaseOrderID])
        REFERENCES [Purchasing].[PurchaseOrderHeader] ([PurchaseOrderID])

    ,CONSTRAINT [CK_PurchaseOrderDetail_OrderQty]
        CHECK (([OrderQty]>(0)))

    ,CONSTRAINT [CK_PurchaseOrderDetail_ReceivedQty]
        CHECK (([ReceivedQty]>=(0.00)))

    ,CONSTRAINT [CK_PurchaseOrderDetail_RejectedQty]
        CHECK (([RejectedQty]>=(0.00)))

    ,CONSTRAINT [CK_PurchaseOrderDetail_UnitPrice]
        CHECK (([UnitPrice]>=(0.00)))
)
GO

ALTER TABLE [Purchasing].[PurchaseOrderDetail] ADD CONSTRAINT [DF_PurchaseOrderDetail_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
