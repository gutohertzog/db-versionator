USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[StateProvince] (
    [StateProvinceID] int NOT NULL IDENTITY(1,1) -- PK
    ,[StateProvinceCode] nchar(6) NOT NULL
    ,[CountryRegionCode] nvarchar(3) NOT NULL -- FK [CountryRegion]
    ,[IsOnlyStateProvinceFlag] Flag NOT NULL -- DF [1]
    ,[Name] Name NOT NULL
    ,[TerritoryID] int NOT NULL -- FK [SalesTerritory]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_StateProvince_StateProvinceID]
        PRIMARY KEY ([StateProvinceID])

    ,CONSTRAINT [FK_StateProvince_CountryRegion_CountryRegionCode]
        FOREIGN KEY ([CountryRegionCode])
        REFERENCES [Person].[CountryRegion] ([CountryRegionCode])

    ,CONSTRAINT [FK_StateProvince_SalesTerritory_TerritoryID]
        FOREIGN KEY ([TerritoryID])
        REFERENCES [Person].[SalesTerritory] ([TerritoryID])
)
GO

ALTER TABLE [Person].[StateProvince] ADD CONSTRAINT [DF_StateProvince_IsOnlyStateProvinceFlag]
    DEFAULT (((1))) FOR [IsOnlyStateProvinceFlag]
GO

ALTER TABLE [Person].[StateProvince] ADD CONSTRAINT [DF_StateProvince_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[StateProvince] ADD CONSTRAINT [DF_StateProvince_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
