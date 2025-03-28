USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[PersonCreditCard] (
    [BusinessEntityID] int NOT NULL -- PK FK [Person]
    ,[CreditCardID] int NOT NULL -- PK FK [CreditCard]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_PersonCreditCard_BusinessEntityID_CreditCardID]
        PRIMARY KEY ([BusinessEntityID], [CreditCardID])

    ,CONSTRAINT [FK_PersonCreditCard_CreditCard_CreditCardID]
        FOREIGN KEY ([CreditCardID])
        REFERENCES [Sales].[CreditCard] ([CreditCardID])

    ,CONSTRAINT [FK_PersonCreditCard_Person_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Sales].[Person] ([BusinessEntityID])
)
GO

ALTER TABLE [Sales].[PersonCreditCard] ADD CONSTRAINT [DF_PersonCreditCard_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
