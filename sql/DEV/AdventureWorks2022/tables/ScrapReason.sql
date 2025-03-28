USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ScrapReason] (
    [ScrapReasonID] smallint NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ScrapReason_ScrapReasonID]
        PRIMARY KEY ([ScrapReasonID])
)
GO

ALTER TABLE [Production].[ScrapReason] ADD CONSTRAINT [DF_ScrapReason_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
