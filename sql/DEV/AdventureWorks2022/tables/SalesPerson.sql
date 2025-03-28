USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SalesPerson] (
    [BusinessEntityID] int NOT NULL -- PK FK [Employee]
    ,[TerritoryID] int NULL -- FK [SalesTerritory]
    ,[SalesQuota] money NULL -- CK [> 0.00 ]
    ,[Bonus] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[CommissionPct] smallmoney NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[SalesYTD] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[SalesLastYear] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SalesPerson_BusinessEntityID]
        PRIMARY KEY ([BusinessEntityID])

    ,CONSTRAINT [FK_SalesPerson_Employee_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Sales].[Employee] ([BusinessEntityID])

    ,CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID]
        FOREIGN KEY ([TerritoryID])
        REFERENCES [Sales].[SalesTerritory] ([TerritoryID])

    ,CONSTRAINT [CK_SalesPerson_Bonus]
        CHECK (([Bonus]>=(0.00)))

    ,CONSTRAINT [CK_SalesPerson_CommissionPct]
        CHECK (([CommissionPct]>=(0.00)))

    ,CONSTRAINT [CK_SalesPerson_SalesLastYear]
        CHECK (([SalesLastYear]>=(0.00)))

    ,CONSTRAINT [CK_SalesPerson_SalesQuota]
        CHECK (([SalesQuota]>(0.00)))

    ,CONSTRAINT [CK_SalesPerson_SalesYTD]
        CHECK (([SalesYTD]>=(0.00)))
)
GO

ALTER TABLE [Sales].[SalesPerson] ADD CONSTRAINT [DF_SalesPerson_Bonus]
    DEFAULT (((0.00))) FOR [Bonus]
GO

ALTER TABLE [Sales].[SalesPerson] ADD CONSTRAINT [DF_SalesPerson_CommissionPct]
    DEFAULT (((0.00))) FOR [CommissionPct]
GO

ALTER TABLE [Sales].[SalesPerson] ADD CONSTRAINT [DF_SalesPerson_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SalesPerson] ADD CONSTRAINT [DF_SalesPerson_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO

ALTER TABLE [Sales].[SalesPerson] ADD CONSTRAINT [DF_SalesPerson_SalesLastYear]
    DEFAULT (((0.00))) FOR [SalesLastYear]
GO

ALTER TABLE [Sales].[SalesPerson] ADD CONSTRAINT [DF_SalesPerson_SalesYTD]
    DEFAULT (((0.00))) FOR [SalesYTD]
GO
