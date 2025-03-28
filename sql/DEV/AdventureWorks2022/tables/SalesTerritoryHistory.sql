USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SalesTerritoryHistory] (
    [BusinessEntityID] int NOT NULL -- PK FK [SalesPerson]
    ,[TerritoryID] int NOT NULL -- PK FK [SalesTerritory]
    ,[StartDate] datetime NOT NULL -- PK
    ,[EndDate] datetime NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID]
        PRIMARY KEY ([BusinessEntityID], [StartDate], [TerritoryID])

    ,CONSTRAINT [FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])

    ,CONSTRAINT [FK_SalesTerritoryHistory_SalesTerritory_TerritoryID]
        FOREIGN KEY ([TerritoryID])
        REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
)
GO

ALTER TABLE [Sales].[SalesTerritoryHistory] ADD CONSTRAINT [DF_SalesTerritoryHistory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SalesTerritoryHistory] ADD CONSTRAINT [DF_SalesTerritoryHistory_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
