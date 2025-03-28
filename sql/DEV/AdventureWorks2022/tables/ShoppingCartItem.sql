USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[ShoppingCartItem] (
    [ShoppingCartItemID] int NOT NULL IDENTITY(1,1) -- PK
    ,[ShoppingCartID] nvarchar(50) NOT NULL
    ,[Quantity] int NOT NULL -- DF [1] CK [>= 1 ]
    ,[ProductID] int NOT NULL -- FK [Product]
    ,[DateCreated] datetime NOT NULL -- DF [getdate()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ShoppingCartItem_ShoppingCartItemID]
        PRIMARY KEY ([ShoppingCartItemID])

    ,CONSTRAINT [FK_ShoppingCartItem_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Sales].[Product] ([ProductID])

    ,CONSTRAINT [CK_ShoppingCartItem_Quantity]
        CHECK (([Quantity]>=(1)))
)
GO

ALTER TABLE [Sales].[ShoppingCartItem] ADD CONSTRAINT [DF_ShoppingCartItem_DateCreated]
    DEFAULT ((getdate())) FOR [DateCreated]
GO

ALTER TABLE [Sales].[ShoppingCartItem] ADD CONSTRAINT [DF_ShoppingCartItem_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[ShoppingCartItem] ADD CONSTRAINT [DF_ShoppingCartItem_Quantity]
    DEFAULT (((1))) FOR [Quantity]
GO
