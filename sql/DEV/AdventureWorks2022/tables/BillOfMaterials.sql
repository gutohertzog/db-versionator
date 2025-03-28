USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[BillOfMaterials] (
    [BillOfMaterialsID] int NOT NULL IDENTITY(1,1) -- PK
    ,[ProductAssemblyID] int NULL -- FK [Product]
    ,[ComponentID] int NOT NULL -- FK [Product]
    ,[StartDate] datetime NOT NULL -- DF [getdate()]
    ,[EndDate] datetime NULL
    ,[UnitMeasureCode] nchar(6) NOT NULL -- FK [UnitMeasure]
    ,[BOMLevel] smallint NOT NULL
    ,[PerAssemblyQty] decimal(8, 2) NOT NULL -- DF [1.00] CK [>= 1.00 ]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_BillOfMaterials_BillOfMaterialsID]
        PRIMARY KEY ([BillOfMaterialsID])

    ,CONSTRAINT [FK_BillOfMaterials_Product_ComponentID]
        FOREIGN KEY ([ComponentID])
        REFERENCES [Production].[Product] ([ProductID])

    ,CONSTRAINT [FK_BillOfMaterials_Product_ProductAssemblyID]
        FOREIGN KEY ([ProductAssemblyID])
        REFERENCES [Production].[Product] ([ProductID])

    ,CONSTRAINT [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode]
        FOREIGN KEY ([UnitMeasureCode])
        REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])

    ,CONSTRAINT [CK_BillOfMaterials_PerAssemblyQty]
        CHECK (([PerAssemblyQty]>=(1.00)))
)
GO

ALTER TABLE [Production].[BillOfMaterials] ADD CONSTRAINT [DF_BillOfMaterials_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[BillOfMaterials] ADD CONSTRAINT [DF_BillOfMaterials_PerAssemblyQty]
    DEFAULT (((1.00))) FOR [PerAssemblyQty]
GO

ALTER TABLE [Production].[BillOfMaterials] ADD CONSTRAINT [DF_BillOfMaterials_StartDate]
    DEFAULT ((getdate())) FOR [StartDate]
GO
