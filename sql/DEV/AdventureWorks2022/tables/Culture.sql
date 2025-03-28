USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[Culture] (
    [CultureID] nchar(12) NOT NULL -- PK
    ,[Name] Name NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Culture_CultureID]
        PRIMARY KEY ([CultureID])
)
GO

ALTER TABLE [Production].[Culture] ADD CONSTRAINT [DF_Culture_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
