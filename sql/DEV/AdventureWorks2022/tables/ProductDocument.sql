USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductDocument] (
    [ProductID] int NOT NULL -- PK FK [Product]
    ,[DocumentNode] hierarchyid NOT NULL -- PK FK [Document]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductDocument_ProductID_DocumentNode]
        PRIMARY KEY ([ProductID], [DocumentNode])

    ,CONSTRAINT [FK_ProductDocument_Document_DocumentNode]
        FOREIGN KEY ([DocumentNode])
        REFERENCES [Production].[Document] ([DocumentNode])

    ,CONSTRAINT [FK_ProductDocument_Product_ProductID]
        FOREIGN KEY ([ProductID])
        REFERENCES [Production].[Product] ([ProductID])
)
GO

ALTER TABLE [Production].[ProductDocument] ADD CONSTRAINT [DF_ProductDocument_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
