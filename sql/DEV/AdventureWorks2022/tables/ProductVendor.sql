USE [AdventureWorks2022]
GO

CREATE TABLE [Purchasing].[ProductVendor] (
    [ProductID] int NOT NULL -- PK FK [Product]
    ,[BusinessEntityID] int NOT NULL -- PK FK [Vendor]
    ,[AverageLeadTime] int NOT NULL -- CK [>= 1 ]
    ,[StandardPrice] money NOT NULL -- CK [> 0.00 ]
    ,[LastReceiptCost] money NULL -- CK [> 0.00 ]
    ,[LastReceiptDate] datetime NULL
    ,[MinOrderQty] int NOT NULL -- CK [>= 1 ]
    ,[MaxOrderQty] int NOT NULL -- CK [>= 1 ]
    ,[OnOrderQty] int NULL -- CK [>= 0 ]
    ,[UnitMeasureCode] nchar(6) NOT NULL -- FK [UnitMeasure]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductVendor_ProductID_BusinessEntityID]
        PRIMARY KEY ([ProductID], [BusinessEntityID])

    ,CONSTRAINT [FK_ProductVendor_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Purchasing].[Product] ([ProductID])

    ,CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode]
        FOREIGN KEY ([UnitMeasureCode])
        REFERENCES [Purchasing].[UnitMeasure] ([UnitMeasureCode])

    ,CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])

    ,CONSTRAINT [CK_ProductVendor_AverageLeadTime]
        CHECK (([AverageLeadTime]>=(1)))

    ,CONSTRAINT [CK_ProductVendor_LastReceiptCost]
        CHECK (([LastReceiptCost]>(0.00)))

    ,CONSTRAINT [CK_ProductVendor_MaxOrderQty]
        CHECK (([MaxOrderQty]>=(1)))

    ,CONSTRAINT [CK_ProductVendor_MinOrderQty]
        CHECK (([MinOrderQty]>=(1)))

    ,CONSTRAINT [CK_ProductVendor_OnOrderQty]
        CHECK (([OnOrderQty]>=(0)))

    ,CONSTRAINT [CK_ProductVendor_StandardPrice]
        CHECK (([StandardPrice]>(0.00)))
)
GO

ALTER TABLE [Purchasing].[ProductVendor] ADD CONSTRAINT [DF_ProductVendor_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
