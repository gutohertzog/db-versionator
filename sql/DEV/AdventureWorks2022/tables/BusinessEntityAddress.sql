USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[BusinessEntityAddress] (
    [BusinessEntityID] int NOT NULL -- PK FK [BusinessEntity]
    ,[AddressID] int NOT NULL -- PK FK [Address]
    ,[AddressTypeID] int NOT NULL -- PK FK [AddressType]
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID]
        PRIMARY KEY ([BusinessEntityID], [AddressID], [AddressTypeID])

    ,CONSTRAINT [FK_BusinessEntityAddress_Address_AddressID]
        FOREIGN KEY ([AddressID])
        REFERENCES [Person].[Address] ([AddressID])

    ,CONSTRAINT [FK_BusinessEntityAddress_AddressType_AddressTypeID]
        FOREIGN KEY ([AddressTypeID])
        REFERENCES [Person].[AddressType] ([AddressTypeID])

    ,CONSTRAINT [FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
)
GO

ALTER TABLE [Person].[BusinessEntityAddress] ADD CONSTRAINT [DF_BusinessEntityAddress_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[BusinessEntityAddress] ADD CONSTRAINT [DF_BusinessEntityAddress_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
