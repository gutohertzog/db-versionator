USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[WorkOrder] (
    [WorkOrderID] int NOT NULL IDENTITY(1,1) -- PK
    ,[ProductID] int NOT NULL -- FK [Product]
    ,[OrderQty] int NOT NULL -- CK [> 0 ]
    ,[StockedQty] int NOT NULL
    ,[ScrappedQty] smallint NOT NULL -- CK [>= 0 ]
    ,[StartDate] datetime NOT NULL
    ,[EndDate] datetime NULL
    ,[DueDate] datetime NOT NULL
    ,[ScrapReasonID] smallint NULL -- FK [ScrapReason]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_WorkOrder_WorkOrderID]
        PRIMARY KEY ([WorkOrderID])

    ,CONSTRAINT [FK_WorkOrder_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Production].[Product] ([ProductID])

    ,CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID]
        FOREIGN KEY ([ScrapReasonID])
        REFERENCES [Production].[ScrapReason] ([ScrapReasonID])

    ,CONSTRAINT [CK_WorkOrder_OrderQty]
        CHECK (([OrderQty]>(0)))

    ,CONSTRAINT [CK_WorkOrder_ScrappedQty]
        CHECK (([ScrappedQty]>=(0)))
)
GO

ALTER TABLE [Production].[WorkOrder] ADD CONSTRAINT [DF_WorkOrder_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
