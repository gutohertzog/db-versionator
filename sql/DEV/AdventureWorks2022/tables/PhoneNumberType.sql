USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[PhoneNumberType] (
    [PhoneNumberTypeID] int NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_PhoneNumberType_PhoneNumberTypeID]
        PRIMARY KEY ([PhoneNumberTypeID])
)
GO

ALTER TABLE [Person].[PhoneNumberType] ADD CONSTRAINT [DF_PhoneNumberType_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
