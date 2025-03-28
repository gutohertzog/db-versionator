USE [AdventureWorks2022]
GO

CREATE TABLE [Purchasing].[ShipMethod] (
    [ShipMethodID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[ShipBase] money NOT NULL -- DF [0.00] CK [> 0.00 ]
    ,[ShipRate] money NOT NULL -- DF [0.00] CK [> 0.00 ]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ShipMethod_ShipMethodID]
        PRIMARY KEY ([ShipMethodID])

    ,CONSTRAINT [CK_ShipMethod_ShipBase]
        CHECK (([ShipBase]>(0.00)))

    ,CONSTRAINT [CK_ShipMethod_ShipRate]
        CHECK (([ShipRate]>(0.00)))
)
GO

ALTER TABLE [Purchasing].[ShipMethod] ADD CONSTRAINT [DF_ShipMethod_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Purchasing].[ShipMethod] ADD CONSTRAINT [DF_ShipMethod_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO

ALTER TABLE [Purchasing].[ShipMethod] ADD CONSTRAINT [DF_ShipMethod_ShipBase]
    DEFAULT (((0.00))) FOR [ShipBase]
GO

ALTER TABLE [Purchasing].[ShipMethod] ADD CONSTRAINT [DF_ShipMethod_ShipRate]
    DEFAULT (((0.00))) FOR [ShipRate]
GO
