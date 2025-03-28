USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductListPriceHistory] (
    [ProductID] int NOT NULL -- PK FK [Product]
    ,[StartDate] datetime NOT NULL -- PK
    ,[EndDate] datetime NULL
    ,[ListPrice] money NOT NULL -- CK [> 0.00 ]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductListPriceHistory_ProductID_StartDate]
        PRIMARY KEY ([ProductID], [StartDate])

    ,CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Production].[Product] ([ProductID])

    ,CONSTRAINT [CK_ProductListPriceHistory_ListPrice]
        CHECK (([ListPrice]>(0.00)))
)
GO

ALTER TABLE [Production].[ProductListPriceHistory] ADD CONSTRAINT [DF_ProductListPriceHistory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
