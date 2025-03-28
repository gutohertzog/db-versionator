USE [AdventureWorks2022]
GO

CREATE TABLE [Purchasing].[PurchaseOrderHeader] (
    [PurchaseOrderID] int NOT NULL IDENTITY(1,1) -- PK
    ,[RevisionNumber] tinyint NOT NULL -- DF [0]
    ,[Status] tinyint NOT NULL -- DF [1] CK [>= 1 AND <= 4 ]
    ,[EmployeeID] int NOT NULL -- FK [Employee]
    ,[VendorID] int NOT NULL -- FK [Vendor]
    ,[ShipMethodID] int NOT NULL -- FK [ShipMethod]
    ,[OrderDate] datetime NOT NULL -- DF [getdate()]
    ,[ShipDate] datetime NULL
    ,[SubTotal] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[TaxAmt] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[Freight] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[TotalDue] money NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_PurchaseOrderHeader_PurchaseOrderID]
        PRIMARY KEY ([PurchaseOrderID])

    ,CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID]
        FOREIGN KEY ([EmployeeID])
        REFERENCES [Purchasing].[Employee] ([BusinessEntityID])

    ,CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID]
        FOREIGN KEY ([ShipMethodID])
        REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID])

    ,CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID]
        FOREIGN KEY ([VendorID])
        REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])

    ,CONSTRAINT [CK_PurchaseOrderHeader_Freight]
        CHECK (([Freight]>=(0.00)))

    ,CONSTRAINT [CK_PurchaseOrderHeader_Status]
        CHECK (([Status]>=(1) AND [Status]<=(4)))

    ,CONSTRAINT [CK_PurchaseOrderHeader_SubTotal]
        CHECK (([SubTotal]>=(0.00)))

    ,CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt]
        CHECK (([TaxAmt]>=(0.00)))
)
GO

ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD CONSTRAINT [DF_PurchaseOrderHeader_Freight]
    DEFAULT (((0.00))) FOR [Freight]
GO

ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD CONSTRAINT [DF_PurchaseOrderHeader_OrderDate]
    DEFAULT ((getdate())) FOR [OrderDate]
GO

ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD CONSTRAINT [DF_PurchaseOrderHeader_RevisionNumber]
    DEFAULT (((0))) FOR [RevisionNumber]
GO

ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD CONSTRAINT [DF_PurchaseOrderHeader_Status]
    DEFAULT (((1))) FOR [Status]
GO

ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD CONSTRAINT [DF_PurchaseOrderHeader_SubTotal]
    DEFAULT (((0.00))) FOR [SubTotal]
GO

ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt]
    DEFAULT (((0.00))) FOR [TaxAmt]
GO
