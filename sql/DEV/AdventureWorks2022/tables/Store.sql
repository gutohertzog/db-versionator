USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[Store] (
    [BusinessEntityID] int NOT NULL -- PK FK [BusinessEntity]
    ,[Name] Name NOT NULL
    ,[SalesPersonID] int NULL -- FK [SalesPerson]
    ,[Demographics] xml NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Store_BusinessEntityID]
        PRIMARY KEY ([BusinessEntityID])

    ,CONSTRAINT [FK_Store_BusinessEntity_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Sales].[BusinessEntity] ([BusinessEntityID])

    ,CONSTRAINT [FK_Store_SalesPerson_SalesPersonID]
        FOREIGN KEY ([SalesPersonID])
        REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
)
GO

ALTER TABLE [Sales].[Store] ADD CONSTRAINT [DF_Store_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[Store] ADD CONSTRAINT [DF_Store_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
