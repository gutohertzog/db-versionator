USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[Product] (
    [ProductID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[ProductNumber] nvarchar(25) NOT NULL
    ,[MakeFlag] Flag NOT NULL -- DF [1]
    ,[FinishedGoodsFlag] Flag NOT NULL -- DF [1]
    ,[Color] nvarchar(15) NULL
    ,[SafetyStockLevel] smallint NOT NULL -- CK [> 0 ]
    ,[ReorderPoint] smallint NOT NULL -- CK [> 0 ]
    ,[StandardCost] money NOT NULL -- CK [>= 0.00 ]
    ,[ListPrice] money NOT NULL -- CK [>= 0.00 ]
    ,[Size] nvarchar(5) NULL
    ,[SizeUnitMeasureCode] nchar(6) NULL -- FK [UnitMeasure]
    ,[WeightUnitMeasureCode] nchar(6) NULL -- FK [UnitMeasure]
    ,[Weight] decimal(8, 2) NULL -- CK [> 0.00 ]
    ,[DaysToManufacture] int NOT NULL -- CK [>= 0 ]
    ,[ProductLine] nchar(4) NULL -- CK [upper 'R' OR upper 'M' OR upper 'T' OR upper 'S' OR IS NULL]
    ,[Class] nchar(4) NULL -- CK [upper 'H' OR upper 'M' OR upper 'L' OR IS NULL]
    ,[Style] nchar(4) NULL -- CK [upper 'U' OR upper 'M' OR upper 'W' OR IS NULL]
    ,[ProductSubcategoryID] int NULL -- FK [ProductSubcategory]
    ,[ProductModelID] int NULL -- FK [ProductModel]
    ,[SellStartDate] datetime NOT NULL
    ,[SellEndDate] datetime NULL
    ,[DiscontinuedDate] datetime NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Product_ProductID]
        PRIMARY KEY ([ProductID])

    ,CONSTRAINT [FK_Product_ProductModel_ProductModelID]
        FOREIGN KEY ([ProductModelID])
        REFERENCES [Production].[ProductModel] ([ProductModelID])

    ,CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID]
        FOREIGN KEY ([ProductSubcategoryID])
        REFERENCES [Production].[ProductSubcategory] ([ProductSubcategoryID])

    ,CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode]
        FOREIGN KEY ([SizeUnitMeasureCode])
        REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])

    ,CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode]
        FOREIGN KEY ([WeightUnitMeasureCode])
        REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])

    ,CONSTRAINT [CK_Product_Class]
        CHECK ((upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL))

    ,CONSTRAINT [CK_Product_DaysToManufacture]
        CHECK (([DaysToManufacture]>=(0)))

    ,CONSTRAINT [CK_Product_ListPrice]
        CHECK (([ListPrice]>=(0.00)))

    ,CONSTRAINT [CK_Product_ProductLine]
        CHECK ((upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL))

    ,CONSTRAINT [CK_Product_ReorderPoint]
        CHECK (([ReorderPoint]>(0)))

    ,CONSTRAINT [CK_Product_SafetyStockLevel]
        CHECK (([SafetyStockLevel]>(0)))

    ,CONSTRAINT [CK_Product_StandardCost]
        CHECK (([StandardCost]>=(0.00)))

    ,CONSTRAINT [CK_Product_Style]
        CHECK ((upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL))

    ,CONSTRAINT [CK_Product_Weight]
        CHECK (([Weight]>(0.00)))
)
GO

ALTER TABLE [Production].[Product] ADD CONSTRAINT [DF_Product_FinishedGoodsFlag]
    DEFAULT (((1))) FOR [FinishedGoodsFlag]
GO

ALTER TABLE [Production].[Product] ADD CONSTRAINT [DF_Product_MakeFlag]
    DEFAULT (((1))) FOR [MakeFlag]
GO

ALTER TABLE [Production].[Product] ADD CONSTRAINT [DF_Product_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[Product] ADD CONSTRAINT [DF_Product_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
