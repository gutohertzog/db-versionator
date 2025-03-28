USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[ProductModelIllustration] (
    [ProductModelID] int NOT NULL -- PK FK [ProductModel]
    ,[IllustrationID] int NOT NULL -- PK FK [Illustration]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_ProductModelIllustration_ProductModelID_IllustrationID]
        PRIMARY KEY ([ProductModelID], [IllustrationID])

    ,CONSTRAINT [FK_ProductModelIllustration_Illustration_IllustrationID]
        FOREIGN KEY ([IllustrationID])
        REFERENCES [Production].[Illustration] ([IllustrationID])

    ,CONSTRAINT [FK_ProductModelIllustration_ProductModel_ProductModelID]
        FOREIGN KEY ([ProductModelID])
        REFERENCES [Production].[ProductModel] ([ProductModelID])
)
GO

ALTER TABLE [Production].[ProductModelIllustration] ADD CONSTRAINT [DF_ProductModelIllustration_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
