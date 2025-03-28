USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[Document] (
    [DocumentNode] hierarchyid NOT NULL -- PK
    ,[DocumentLevel] smallint NULL
    ,[Title] nvarchar(50) NOT NULL
    ,[Owner] int NOT NULL -- FK [Employee]
    ,[FolderFlag] bit NOT NULL -- DF [0]
    ,[FileName] nvarchar(400) NOT NULL
    ,[FileExtension] nvarchar(8) NOT NULL
    ,[Revision] nchar(10) NOT NULL
    ,[ChangeNumber] int NOT NULL -- DF [0]
    ,[Status] tinyint NOT NULL -- CK [>= 1 AND <= 3 ]
    ,[DocumentSummary] nvarchar(MAX) NULL
    ,[Document] varbinary(MAX) NULL
    ,[rowguid] uniqueidentifier NOT NULL -- UK DF [newid()]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Document_DocumentNode]
        PRIMARY KEY ([DocumentNode])

    ,CONSTRAINT [UQ__Document__F73921F7C81C642F]
        UNIQUE CLUSTERED ([rowguid], [rowguid])

    ,CONSTRAINT [FK_Document_Employee_Owner]
        FOREIGN KEY ([Owner])
        REFERENCES [Production].[Employee] ([BusinessEntityID])

    ,CONSTRAINT [CK_Document_Status]
        CHECK (([Status]>=(1) AND [Status]<=(3)))
)
GO

ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF_Document_ChangeNumber]
    DEFAULT (((0))) FOR [ChangeNumber]
GO

ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF_Document_FolderFlag]
    DEFAULT (((0))) FOR [FolderFlag]
GO

ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF_Document_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF_Document_rowguid]
    DEFAULT ((newid())) FOR [rowguid]
GO
