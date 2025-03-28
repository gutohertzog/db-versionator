USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[Currency] (
    [CurrencyCode] nchar(6) NOT NULL -- PK
    ,[Name] Name NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Currency_CurrencyCode]
        PRIMARY KEY ([CurrencyCode])
)
GO

ALTER TABLE [Sales].[Currency] ADD CONSTRAINT [DF_Currency_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
