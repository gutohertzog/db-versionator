USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SalesOrderHeader] (
    [SalesOrderID] int NOT NULL IDENTITY(1,1) -- PK
    ,[RevisionNumber] tinyint NOT NULL -- DF [0]
    ,[OrderDate] datetime NOT NULL -- DF [getdate()]
    ,[DueDate] datetime NOT NULL
    ,[ShipDate] datetime NULL
    ,[Status] tinyint NOT NULL -- DF [1] CK [>= 0 AND <= 8 ]
    ,[OnlineOrderFlag] Flag NOT NULL -- DF [1]
    ,[SalesOrderNumber] nvarchar(25) NOT NULL
    ,[PurchaseOrderNumber] OrderNumber NULL
    ,[AccountNumber] AccountNumber NULL
    ,[CustomerID] int NOT NULL -- FK [Customer]
    ,[SalesPersonID] int NULL -- FK [SalesPerson]
    ,[TerritoryID] int NULL -- FK [SalesTerritory]
    ,[BillToAddressID] int NOT NULL -- FK [Address]
    ,[ShipToAddressID] int NOT NULL -- FK [Address]
    ,[ShipMethodID] int NOT NULL -- FK [ShipMethod]
    ,[CreditCardID] int NULL -- FK [CreditCard]
    ,[CreditCardApprovalCode] varchar(15) NULL
    ,[CurrencyRateID] int NULL -- FK [CurrencyRate]
    ,[SubTotal] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[TaxAmt] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[Freight] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[TotalDue] money NOT NULL
    ,[Comment] nvarchar(128) NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SalesOrderHeader_SalesOrderID]
        PRIMARY KEY ([SalesOrderID])

    ,CONSTRAINT [FK_SalesOrderHeader_Address_BillToAddressID]
        FOREIGN KEY ([BillToAddressID])
        REFERENCES [Sales].[Address] ([AddressID])

    ,CONSTRAINT [FK_SalesOrderHeader_Address_ShipToAddressID]
        FOREIGN KEY ([ShipToAddressID])
        REFERENCES [Sales].[Address] ([AddressID])

    ,CONSTRAINT [FK_SalesOrderHeader_CreditCard_CreditCardID]
        FOREIGN KEY ([CreditCardID])
        REFERENCES [Sales].[CreditCard] ([CreditCardID])

    ,CONSTRAINT [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID]
        FOREIGN KEY ([CurrencyRateID])
        REFERENCES [Sales].[CurrencyRate] ([CurrencyRateID])

    ,CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID]
        FOREIGN KEY ([CustomerID])
        REFERENCES [Sales].[Customer] ([CustomerID])

    ,CONSTRAINT [FK_SalesOrderHeader_SalesPerson_SalesPersonID]
        FOREIGN KEY ([SalesPersonID])
        REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])

    ,CONSTRAINT [FK_SalesOrderHeader_SalesTerritory_TerritoryID]
        FOREIGN KEY ([TerritoryID])
        REFERENCES [Sales].[SalesTerritory] ([TerritoryID])

    ,CONSTRAINT [FK_SalesOrderHeader_ShipMethod_ShipMethodID]
        FOREIGN KEY ([ShipMethodID])
        REFERENCES [Sales].[ShipMethod] ([ShipMethodID])

    ,CONSTRAINT [CK_SalesOrderHeader_Freight]
        CHECK (([Freight]>=(0.00)))

    ,CONSTRAINT [CK_SalesOrderHeader_Status]
        CHECK (([Status]>=(0) AND [Status]<=(8)))

    ,CONSTRAINT [CK_SalesOrderHeader_SubTotal]
        CHECK (([SubTotal]>=(0.00)))

    ,CONSTRAINT [CK_SalesOrderHeader_TaxAmt]
        CHECK (([TaxAmt]>=(0.00)))
)
GO

ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT [DF_SalesOrderHeader_Freight]
    DEFAULT (((0.00))) FOR [Freight]
GO

ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT [DF_SalesOrderHeader_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag]
    DEFAULT (((1))) FOR [OnlineOrderFlag]
GO

ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT [DF_SalesOrderHeader_OrderDate]
    DEFAULT ((getdate())) FOR [OrderDate]
GO

ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT [DF_SalesOrderHeader_RevisionNumber]
    DEFAULT (((0))) FOR [RevisionNumber]
GO

ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT [DF_SalesOrderHeader_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO

ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT [DF_SalesOrderHeader_Status]
    DEFAULT (((1))) FOR [Status]
GO

ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT [DF_SalesOrderHeader_SubTotal]
    DEFAULT (((0.00))) FOR [SubTotal]
GO

ALTER TABLE [Sales].[SalesOrderHeader] ADD CONSTRAINT [DF_SalesOrderHeader_TaxAmt]
    DEFAULT (((0.00))) FOR [TaxAmt]
GO
