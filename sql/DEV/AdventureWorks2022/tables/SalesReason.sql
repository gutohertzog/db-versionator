USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SalesReason] (
    [SalesReasonID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[ReasonType] Name NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SalesReason_SalesReasonID]
        PRIMARY KEY ([SalesReasonID])
)
GO

ALTER TABLE [Sales].[SalesReason] ADD CONSTRAINT [DF_SalesReason_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
