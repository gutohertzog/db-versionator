USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[Address] (
    [AddressID] int NOT NULL IDENTITY(1,1) -- PK
    ,[AddressLine1] nvarchar(60) NOT NULL
    ,[AddressLine2] nvarchar(60) NULL
    ,[City] nvarchar(30) NOT NULL
    ,[StateProvinceID] int NOT NULL -- FK [StateProvince]
    ,[PostalCode] nvarchar(15) NOT NULL
    ,[SpatialLocation] geography NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Address_AddressID]
        PRIMARY KEY ([AddressID])

    ,CONSTRAINT [FK_Address_StateProvince_StateProvinceID]
        FOREIGN KEY ([StateProvinceID])
        REFERENCES [Person].[StateProvince] ([StateProvinceID])
)
GO

ALTER TABLE [Person].[Address] ADD CONSTRAINT [DF_Address_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[Address] ADD CONSTRAINT [DF_Address_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
