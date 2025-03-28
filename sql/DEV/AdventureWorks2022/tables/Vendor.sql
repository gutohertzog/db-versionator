USE [AdventureWorks2022]
GO

CREATE TABLE [Purchasing].[Vendor] (
    [BusinessEntityID] int NOT NULL -- PK FK [BusinessEntity]
    ,[AccountNumber] AccountNumber NOT NULL
    ,[Name] Name NOT NULL
    ,[CreditRating] tinyint NOT NULL -- CK [>= 1 AND <= 5 ]
    ,[PreferredVendorStatus] Flag NOT NULL -- DF [1]
    ,[ActiveFlag] Flag NOT NULL -- DF [1]
    ,[PurchasingWebServiceURL] nvarchar(1024) NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Vendor_BusinessEntityID]
        PRIMARY KEY ([BusinessEntityID])

    ,CONSTRAINT [FK_Vendor_BusinessEntity_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Purchasing].[BusinessEntity] ([BusinessEntityID])

    ,CONSTRAINT [CK_Vendor_CreditRating]
        CHECK (([CreditRating]>=(1) AND [CreditRating]<=(5)))
)
GO

ALTER TABLE [Purchasing].[Vendor] ADD CONSTRAINT [DF_Vendor_ActiveFlag]
    DEFAULT (((1))) FOR [ActiveFlag]
GO

ALTER TABLE [Purchasing].[Vendor] ADD CONSTRAINT [DF_Vendor_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Purchasing].[Vendor] ADD CONSTRAINT [DF_Vendor_PreferredVendorStatus]
    DEFAULT (((1))) FOR [PreferredVendorStatus]
GO
