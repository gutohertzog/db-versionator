USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SalesTerritory] (
    [TerritoryID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[CountryRegionCode] nvarchar(3) NOT NULL -- FK [CountryRegion]
    ,[Group] nvarchar(50) NOT NULL
    ,[SalesYTD] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[SalesLastYear] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[CostYTD] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[CostLastYear] money NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SalesTerritory_TerritoryID]
        PRIMARY KEY ([TerritoryID])

    ,CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode]
        FOREIGN KEY ([CountryRegionCode])
        REFERENCES [Sales].[CountryRegion] ([CountryRegionCode])

    ,CONSTRAINT [CK_SalesTerritory_CostLastYear]
        CHECK (([CostLastYear]>=(0.00)))

    ,CONSTRAINT [CK_SalesTerritory_CostYTD]
        CHECK (([CostYTD]>=(0.00)))

    ,CONSTRAINT [CK_SalesTerritory_SalesLastYear]
        CHECK (([SalesLastYear]>=(0.00)))

    ,CONSTRAINT [CK_SalesTerritory_SalesYTD]
        CHECK (([SalesYTD]>=(0.00)))
)
GO

ALTER TABLE [Sales].[SalesTerritory] ADD CONSTRAINT [DF_SalesTerritory_CostLastYear]
    DEFAULT (((0.00))) FOR [CostLastYear]
GO

ALTER TABLE [Sales].[SalesTerritory] ADD CONSTRAINT [DF_SalesTerritory_CostYTD]
    DEFAULT (((0.00))) FOR [CostYTD]
GO

ALTER TABLE [Sales].[SalesTerritory] ADD CONSTRAINT [DF_SalesTerritory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SalesTerritory] ADD CONSTRAINT [DF_SalesTerritory_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO

ALTER TABLE [Sales].[SalesTerritory] ADD CONSTRAINT [DF_SalesTerritory_SalesLastYear]
    DEFAULT (((0.00))) FOR [SalesLastYear]
GO

ALTER TABLE [Sales].[SalesTerritory] ADD CONSTRAINT [DF_SalesTerritory_SalesYTD]
    DEFAULT (((0.00))) FOR [SalesYTD]
GO
