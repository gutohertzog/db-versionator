USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[CreditCard] (
    [CreditCardID] int NOT NULL IDENTITY(1,1) -- PK
    ,[CardType] nvarchar(50) NOT NULL
    ,[CardNumber] nvarchar(25) NOT NULL
    ,[ExpMonth] tinyint NOT NULL
    ,[ExpYear] smallint NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_CreditCard_CreditCardID]
        PRIMARY KEY ([CreditCardID])
)
GO

ALTER TABLE [Sales].[CreditCard] ADD CONSTRAINT [DF_CreditCard_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
