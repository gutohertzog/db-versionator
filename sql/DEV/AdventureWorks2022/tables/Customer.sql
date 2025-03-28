USE [AdventureWorks2022]
GO

CREATE TABLE [Sales].[Customer] (
    [CustomerID] int NOT NULL IDENTITY(1,1) -- PK
    ,[PersonID] int NULL -- FK [Person]
    ,[StoreID] int NULL -- FK [Store]
    ,[TerritoryID] int NULL -- FK [SalesTerritory]
    ,[AccountNumber] varchar(10) NOT NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Customer_CustomerID]
        PRIMARY KEY ([CustomerID])

    ,CONSTRAINT [FK_Customer_Person_PersonID]
        FOREIGN KEY ([PersonID])
        REFERENCES [Sales].[Person] ([BusinessEntityID])

    ,CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID]
        FOREIGN KEY ([TerritoryID])
        REFERENCES [Sales].[SalesTerritory] ([TerritoryID])

    ,CONSTRAINT [FK_Customer_Store_StoreID]
        FOREIGN KEY ([StoreID])
        REFERENCES [Sales].[Store] ([BusinessEntityID])
)
GO

ALTER TABLE [Sales].[Customer] ADD CONSTRAINT [DF_Customer_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[Customer] ADD CONSTRAINT [DF_Customer_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
