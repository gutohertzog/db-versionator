USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[CountryRegion] (
    [CountryRegionCode] nvarchar(3) NOT NULL -- PK
    ,[Name] Name NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_CountryRegion_CountryRegionCode]
        PRIMARY KEY ([CountryRegionCode])
)
GO

ALTER TABLE [Person].[CountryRegion] ADD CONSTRAINT [DF_CountryRegion_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
