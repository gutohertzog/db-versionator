USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[TransactionHistoryArchive] (
    [TransactionID] int NOT NULL -- PK
    ,[ProductID] int NOT NULL
    ,[ReferenceOrderID] int NOT NULL
    ,[ReferenceOrderLineID] int NOT NULL -- DF [0]
    ,[TransactionDate] datetime NOT NULL -- DF [getdate()]
    ,[TransactionType] nchar(2) NOT NULL -- CK [upper 'P' OR upper 'S' OR upper 'W']
    ,[Quantity] int NOT NULL
    ,[ActualCost] money NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_TransactionHistoryArchive_TransactionID]
        PRIMARY KEY ([TransactionID])

    ,CONSTRAINT [CK_TransactionHistoryArchive_TransactionType]
        CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W'))
)
GO

ALTER TABLE [Production].[TransactionHistoryArchive] ADD CONSTRAINT [DF_TransactionHistoryArchive_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[TransactionHistoryArchive] ADD CONSTRAINT [DF_TransactionHistoryArchive_ReferenceOrderLineID]
    DEFAULT (((0))) FOR [ReferenceOrderLineID]
GO

ALTER TABLE [Production].[TransactionHistoryArchive] ADD CONSTRAINT [DF_TransactionHistoryArchive_TransactionDate]
    DEFAULT ((getdate())) FOR [TransactionDate]
GO
