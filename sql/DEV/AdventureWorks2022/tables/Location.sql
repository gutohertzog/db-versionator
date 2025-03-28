USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[Location] (
    [LocationID] smallint NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[CostRate] smallmoney NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[Availability] decimal(8, 2) NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Location_LocationID]
        PRIMARY KEY ([LocationID])

    ,CONSTRAINT [CK_Location_Availability]
        CHECK (([Availability]>=(0.00)))

    ,CONSTRAINT [CK_Location_CostRate]
        CHECK (([CostRate]>=(0.00)))
)
GO

ALTER TABLE [Production].[Location] ADD CONSTRAINT [DF_Location_Availability]
    DEFAULT (((0.00))) FOR [Availability]
GO

ALTER TABLE [Production].[Location] ADD CONSTRAINT [DF_Location_CostRate]
    DEFAULT (((0.00))) FOR [CostRate]
GO

ALTER TABLE [Production].[Location] ADD CONSTRAINT [DF_Location_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
