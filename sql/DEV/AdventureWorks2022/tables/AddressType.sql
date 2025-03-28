USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[AddressType] (
    [AddressTypeID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_AddressType_AddressTypeID]
        PRIMARY KEY ([AddressTypeID])
)
GO

ALTER TABLE [Person].[AddressType] ADD CONSTRAINT [DF_AddressType_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[AddressType] ADD CONSTRAINT [DF_AddressType_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
