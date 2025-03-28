USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductCostHistory] (
    [ProductID] int NOT NULL -- PK FK [Product]
    ,[StartDate] datetime NOT NULL -- PK
    ,[EndDate] datetime NULL
    ,[StandardCost] money NOT NULL -- CK [>= 0.00 ]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductCostHistory_ProductID_StartDate]
        PRIMARY KEY ([ProductID], [StartDate])

    ,CONSTRAINT [FK_ProductCostHistory_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Production].[Product] ([ProductID])

    ,CONSTRAINT [CK_ProductCostHistory_StandardCost]
        CHECK (([StandardCost]>=(0.00)))
)
GO

ALTER TABLE [Production].[ProductCostHistory] ADD CONSTRAINT [DF_ProductCostHistory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
