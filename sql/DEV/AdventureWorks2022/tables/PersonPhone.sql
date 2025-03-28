USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[PersonPhone] (
    [BusinessEntityID] int NOT NULL -- PK FK [Person]
    ,[PhoneNumber] Phone NOT NULL -- PK
    ,[PhoneNumberTypeID] int NOT NULL -- PK FK [PhoneNumberType]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID]
        PRIMARY KEY ([BusinessEntityID], [PhoneNumber], [PhoneNumberTypeID])

    ,CONSTRAINT [FK_PersonPhone_Person_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Person].[Person] ([BusinessEntityID])

    ,CONSTRAINT [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID]
        FOREIGN KEY ([PhoneNumberTypeID])
        REFERENCES [Person].[PhoneNumberType] ([PhoneNumberTypeID])
)
GO

ALTER TABLE [Person].[PersonPhone] ADD CONSTRAINT [DF_PersonPhone_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
