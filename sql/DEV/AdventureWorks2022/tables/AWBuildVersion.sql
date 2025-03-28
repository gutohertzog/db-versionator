USE [AdventureWorks2022]
GO

CREATE TABLE [dbo].[AWBuildVersion] (
    [SystemInformationID] tinyint NOT NULL IDENTITY(1,1) -- PK
    ,[Database Version] nvarchar(25) NOT NULL
    ,[VersionDate] datetime NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_AWBuildVersion_SystemInformationID]
        PRIMARY KEY ([SystemInformationID])
)
GO

ALTER TABLE [dbo].[AWBuildVersion] ADD CONSTRAINT [DF_AWBuildVersion_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
