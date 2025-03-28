USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductPhoto] (
    [ProductPhotoID] int NOT NULL IDENTITY(1,1) -- PK
    ,[ThumbNailPhoto] varbinary(MAX) NULL
    ,[ThumbnailPhotoFileName] nvarchar(50) NULL
    ,[LargePhoto] varbinary(MAX) NULL
    ,[LargePhotoFileName] nvarchar(50) NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductPhoto_ProductPhotoID]
        PRIMARY KEY ([ProductPhotoID])
)
GO

ALTER TABLE [Production].[ProductPhoto] ADD CONSTRAINT [DF_ProductPhoto_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
