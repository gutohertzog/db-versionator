USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[UnitMeasure] (
    [UnitMeasureCode] nchar(6) NOT NULL -- PK
    ,[Name] Name NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_UnitMeasure_UnitMeasureCode]
        PRIMARY KEY ([UnitMeasureCode])
)
GO

ALTER TABLE [Production].[UnitMeasure] ADD CONSTRAINT [DF_UnitMeasure_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
