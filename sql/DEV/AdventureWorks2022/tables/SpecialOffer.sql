USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SpecialOffer] (
    [SpecialOfferID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Description] nvarchar(255) NOT NULL
    ,[DiscountPct] smallmoney NOT NULL -- DF [0.00] CK [>= 0.00 ]
    ,[Type] nvarchar(50) NOT NULL
    ,[Category] nvarchar(50) NOT NULL
    ,[StartDate] datetime NOT NULL
    ,[EndDate] datetime NOT NULL
    ,[MinQty] int NOT NULL -- DF [0] CK [>= 0 ]
    ,[MaxQty] int NULL -- CK [>= 0 ]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SpecialOffer_SpecialOfferID]
        PRIMARY KEY ([SpecialOfferID])

    ,CONSTRAINT [CK_SpecialOffer_DiscountPct]
        CHECK (([DiscountPct]>=(0.00)))

    ,CONSTRAINT [CK_SpecialOffer_MaxQty]
        CHECK (([MaxQty]>=(0)))

    ,CONSTRAINT [CK_SpecialOffer_MinQty]
        CHECK (([MinQty]>=(0)))
)
GO

ALTER TABLE [Sales].[SpecialOffer] ADD CONSTRAINT [DF_SpecialOffer_DiscountPct]
    DEFAULT (((0.00))) FOR [DiscountPct]
GO

ALTER TABLE [Sales].[SpecialOffer] ADD CONSTRAINT [DF_SpecialOffer_MinQty]
    DEFAULT (((0))) FOR [MinQty]
GO

ALTER TABLE [Sales].[SpecialOffer] ADD CONSTRAINT [DF_SpecialOffer_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SpecialOffer] ADD CONSTRAINT [DF_SpecialOffer_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
