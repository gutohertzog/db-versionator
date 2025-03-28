USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[CurrencyRate] (
    [CurrencyRateID] int NOT NULL IDENTITY(1,1) -- PK
    ,[CurrencyRateDate] datetime NOT NULL
    ,[FromCurrencyCode] nchar(6) NOT NULL -- FK [Currency]
    ,[ToCurrencyCode] nchar(6) NOT NULL -- FK [Currency]
    ,[AverageRate] money NOT NULL
    ,[EndOfDayRate] money NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_CurrencyRate_CurrencyRateID]
        PRIMARY KEY ([CurrencyRateID])

    ,CONSTRAINT [FK_CurrencyRate_Currency_FromCurrencyCode]
        FOREIGN KEY ([FromCurrencyCode])
        REFERENCES [Sales].[Currency] ([CurrencyCode])

    ,CONSTRAINT [FK_CurrencyRate_Currency_ToCurrencyCode]
        FOREIGN KEY ([ToCurrencyCode])
        REFERENCES [Sales].[Currency] ([CurrencyCode])
)
GO

ALTER TABLE [Sales].[CurrencyRate] ADD CONSTRAINT [DF_CurrencyRate_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
