USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[SalesPersonQuotaHistory] (
    [BusinessEntityID] int NOT NULL -- PK FK [SalesPerson]
    ,[QuotaDate] datetime NOT NULL -- PK
    ,[SalesQuota] money NOT NULL -- CK [> 0.00 ]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate]
        PRIMARY KEY ([BusinessEntityID], [QuotaDate])

    ,CONSTRAINT [FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])

    ,CONSTRAINT [CK_SalesPersonQuotaHistory_SalesQuota]
        CHECK (([SalesQuota]>(0.00)))
)
GO

ALTER TABLE [Sales].[SalesPersonQuotaHistory] ADD CONSTRAINT [DF_SalesPersonQuotaHistory_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SalesPersonQuotaHistory] ADD CONSTRAINT [DF_SalesPersonQuotaHistory_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
