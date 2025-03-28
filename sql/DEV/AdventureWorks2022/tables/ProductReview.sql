USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductReview] (
    [ProductReviewID] int NOT NULL IDENTITY(1,1) -- PK
    ,[ProductID] int NOT NULL -- FK [Product]
    ,[ReviewerName] Name NOT NULL
    ,[ReviewDate] datetime NOT NULL -- DF [getdate()]
    ,[EmailAddress] nvarchar(50) NOT NULL
    ,[Rating] int NOT NULL -- CK [>= 1 AND <= 5 ]
    ,[Comments] nvarchar(3850) NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductReview_ProductReviewID]
        PRIMARY KEY ([ProductReviewID])

    ,CONSTRAINT [FK_ProductReview_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Production].[Product] ([ProductID])

    ,CONSTRAINT [CK_ProductReview_Rating]
        CHECK (([Rating]>=(1) AND [Rating]<=(5)))
)
GO

ALTER TABLE [Production].[ProductReview] ADD CONSTRAINT [DF_ProductReview_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[ProductReview] ADD CONSTRAINT [DF_ProductReview_ReviewDate]
    DEFAULT ((getdate())) FOR [ReviewDate]
GO
