USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[Illustration] (
    [IllustrationID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Diagram] xml NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Illustration_IllustrationID]
        PRIMARY KEY ([IllustrationID])
)
GO

ALTER TABLE [Production].[Illustration] ADD CONSTRAINT [DF_Illustration_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
