USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_ShoppingCartItem_ShoppingCartID_ProductID] ON [Sales].[ShoppingCartItem]
(
    [ShoppingCartID],
    [ProductID]
)
GO
