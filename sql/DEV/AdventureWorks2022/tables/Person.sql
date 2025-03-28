USE [AdventureWorks2022]
GO

CREATE TABLE [Person].[Person] (
    [BusinessEntityID] int NOT NULL -- PK FK [BusinessEntity]
    ,[PersonType] nchar(4) NOT NULL -- CK [ IS NULL OR upper 'GC' OR upper 'SP' OR upper 'EM' OR upper 'IN' OR upper 'VC' OR upper 'SC' ]
    ,[NameStyle] NameStyle NOT NULL -- DF [0]
    ,[Title] nvarchar(8) NULL
    ,[FirstName] Name NOT NULL
    ,[MiddleName] Name NULL
    ,[LastName] Name NOT NULL
    ,[Suffix] nvarchar(10) NULL
    ,[EmailPromotion] int NOT NULL -- DF [0] CK [>= 0 AND <= 2 ]
    ,[AdditionalContactInfo] xml NULL
    ,[Demographics] xml NULL
    ,[rowguid] uniqueidentifier NOT NULL -- DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Person_BusinessEntityID]
        PRIMARY KEY ([BusinessEntityID])

    ,CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID]
        FOREIGN KEY ([BusinessEntityID])
        REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])

    ,CONSTRAINT [CK_Person_EmailPromotion]
        CHECK (([EmailPromotion]>=(0) AND [EmailPromotion]<=(2)))

    ,CONSTRAINT [CK_Person_PersonType]
        CHECK (([PersonType] IS NULL OR (upper([PersonType])='GC' OR upper([PersonType])='SP' OR upper([PersonType])='EM' OR upper([PersonType])='IN' OR upper([PersonType])='VC' OR upper([PersonType])='SC')))
)
GO

ALTER TABLE [Person].[Person] ADD CONSTRAINT [DF_Person_EmailPromotion]
    DEFAULT (((0))) FOR [EmailPromotion]
GO

ALTER TABLE [Person].[Person] ADD CONSTRAINT [DF_Person_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[Person] ADD CONSTRAINT [DF_Person_NameStyle]
    DEFAULT (((0))) FOR [NameStyle]
GO

ALTER TABLE [Person].[Person] ADD CONSTRAINT [DF_Person_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
