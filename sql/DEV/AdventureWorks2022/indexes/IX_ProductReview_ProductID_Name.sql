USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_ProductReview_ProductID_Name] ON [Production].[ProductReview]
(
    [ProductID],
    [ReviewerName]
)
INCLUDE
(
    [Comments]
)
GO
