USE [msdb]
GO

CREATE TABLE [dbo].[sysssispackagefolders] (
    [folderid] uniqueidentifier NOT NULL -- PK
    ,[parentfolderid] uniqueidentifier NULL -- UK
    ,[foldername] sysname NOT NULL -- UK

    ,CONSTRAINT [PK_sysssispackagefolders]
        PRIMARY KEY ([folderid])

    ,CONSTRAINT [U_sysssispackagefoldersuniquepath]
        UNIQUE CLUSTERED ([parentfolderid], [parentfolderid], [foldername])
)
GO
