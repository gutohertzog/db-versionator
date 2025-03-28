USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductInventory] (
    [ProductID] int NOT NULL -- PK FK [Product]
    ,[LocationID] smallint NOT NULL -- PK FK [Location]
    ,[Shelf] nvarchar(10) NOT NULL -- CK [ like '[A-Za-z]' OR 'N/A']
    ,[Bin] tinyint NOT NULL -- CK [>= 0 AND <= 100 ]
    ,[Quantity] smallint NOT NULL -- DF [0]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductInventory_ProductID_LocationID]
        PRIMARY KEY ([ProductID], [LocationID])

    ,CONSTRAINT [FK_ProductInventory_Location_LocationID]
        FOREIGN KEY ([LocationID])
        REFERENCES [Production].[Location] ([LocationID])

    ,CONSTRAINT [FK_ProductInventory_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Production].[Product] ([ProductID])

    ,CONSTRAINT [CK_ProductInventory_Bin]
        CHECK (([Bin]>=(0) AND [Bin]<=(100)))

    ,CONSTRAINT [CK_ProductInventory_Shelf]
        CHECK (([Shelf] like '[A-Za-z]' OR [Shelf]='N/A'))
)
GO

ALTER TABLE [Production].[ProductInventory] ADD CONSTRAINT [DF_ProductInventory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[ProductInventory] ADD CONSTRAINT [DF_ProductInventory_Quantity]
    DEFAULT (((0))) FOR [Quantity]
GO

ALTER TABLE [Production].[ProductInventory] ADD CONSTRAINT [DF_ProductInventory_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
