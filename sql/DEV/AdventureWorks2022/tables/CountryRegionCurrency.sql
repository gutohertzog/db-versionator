USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[CountryRegionCurrency] (
    [CountryRegionCode] nvarchar(3) NOT NULL -- PK FK [CountryRegion]
    ,[CurrencyCode] nchar(6) NOT NULL -- PK FK [Currency]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode]
        PRIMARY KEY ([CountryRegionCode], [CurrencyCode])

    ,CONSTRAINT [FK_CountryRegionCurrency_CountryRegion_CountryRegionCode]
        FOREIGN KEY ([CountryRegionCode])
        REFERENCES [Sales].[CountryRegion] ([CountryRegionCode])

    ,CONSTRAINT [FK_CountryRegionCurrency_Currency_CurrencyCode]
        FOREIGN KEY ([CurrencyCode])
        REFERENCES [Sales].[Currency] ([CurrencyCode])
)
GO

ALTER TABLE [Sales].[CountryRegionCurrency] ADD CONSTRAINT [DF_CountryRegionCurrency_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
