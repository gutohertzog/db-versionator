USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SalesTaxRate] (
    [SalesTaxRateID] int NOT NULL IDENTITY(1,1) -- PK
    ,[StateProvinceID] int NOT NULL -- FK [StateProvince]
    ,[TaxType] tinyint NOT NULL -- CK [>= 1 AND <= 3 ]
    ,[TaxRate] smallmoney NOT NULL -- DF [0.00]
    ,[Name] Name NOT NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SalesTaxRate_SalesTaxRateID]
        PRIMARY KEY ([SalesTaxRateID])

    ,CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID]
        FOREIGN KEY ([StateProvinceID])
        REFERENCES [Sales].[StateProvince] ([StateProvinceID])

    ,CONSTRAINT [CK_SalesTaxRate_TaxType]
        CHECK (([TaxType]>=(1) AND [TaxType]<=(3)))
)
GO

ALTER TABLE [Sales].[SalesTaxRate] ADD CONSTRAINT [DF_SalesTaxRate_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SalesTaxRate] ADD CONSTRAINT [DF_SalesTaxRate_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO

ALTER TABLE [Sales].[SalesTaxRate] ADD CONSTRAINT [DF_SalesTaxRate_TaxRate]
    DEFAULT (((0.00))) FOR [TaxRate]
GO
