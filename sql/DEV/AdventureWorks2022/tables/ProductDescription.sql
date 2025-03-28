USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductDescription] (
    [ProductDescriptionID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Description] nvarchar(400) NOT NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductDescription_ProductDescriptionID]
        PRIMARY KEY ([ProductDescriptionID])
)
GO

ALTER TABLE [Production].[ProductDescription] ADD CONSTRAINT [DF_ProductDescription_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[ProductDescription] ADD CONSTRAINT [DF_ProductDescription_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
