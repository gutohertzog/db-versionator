USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SalesOrderHeaderSalesReason] (
    [SalesOrderID] int NOT NULL -- PK FK [SalesOrderHeader]
    ,[SalesReasonID] int NOT NULL -- PK FK [SalesReason]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID]
        PRIMARY KEY ([SalesOrderID], [SalesReasonID])

    ,CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID]
        FOREIGN KEY ([SalesOrderID])
        REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID])

    ,CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID]
        FOREIGN KEY ([SalesReasonID])
        REFERENCES [Sales].[SalesReason] ([SalesReasonID])
)
GO

ALTER TABLE [Sales].[SalesOrderHeaderSalesReason] ADD CONSTRAINT [DF_SalesOrderHeaderSalesReason_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
