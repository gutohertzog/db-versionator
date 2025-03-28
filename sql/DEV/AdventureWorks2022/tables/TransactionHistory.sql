USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[TransactionHistory] (
    [TransactionID] int NOT NULL IDENTITY(1,1) -- PK
    ,[ProductID] int NOT NULL -- FK [Product]
    ,[ReferenceOrderID] int NOT NULL
    ,[ReferenceOrderLineID] int NOT NULL -- DF [0]
    ,[TransactionDate] datetime NOT NULL -- DF [getdate()]
    ,[TransactionType] nchar(2) NOT NULL -- CK [upper 'P' OR upper 'S' OR upper 'W']
    ,[Quantity] int NOT NULL
    ,[ActualCost] money NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_TransactionHistory_TransactionID]
        PRIMARY KEY ([TransactionID])

    ,CONSTRAINT [FK_TransactionHistory_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Production].[Product] ([ProductID])

    ,CONSTRAINT [CK_TransactionHistory_TransactionType]
        CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W'))
)
GO

ALTER TABLE [Production].[TransactionHistory] ADD CONSTRAINT [DF_TransactionHistory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[TransactionHistory] ADD CONSTRAINT [DF_TransactionHistory_ReferenceOrderLineID]
    DEFAULT (((0))) FOR [ReferenceOrderLineID]
GO

ALTER TABLE [Production].[TransactionHistory] ADD CONSTRAINT [DF_TransactionHistory_TransactionDate]
    DEFAULT ((getdate())) FOR [TransactionDate]
GO
