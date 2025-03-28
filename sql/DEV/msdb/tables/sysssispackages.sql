USE [msdb]
GO

CREATE TABLE [dbo].[sysssispackages] (
    [name] sysname NOT NULL -- PK
    ,[id] uniqueidentifier NOT NULL
    ,[description] nvarchar(1024) NULL
    ,[createdate] datetime NOT NULL
    ,[folderid] uniqueidentifier NOT NULL -- PK
    ,[ownersid] varbinary(85) NOT NULL
    ,[packagedata] image NOT NULL
    ,[packageformat] int NOT NULL
    ,[packagetype] int NOT NULL -- DF [0]
    ,[vermajor] int NOT NULL
    ,[verminor] int NOT NULL
    ,[verbuild] int NOT NULL
    ,[vercomments] nvarchar(1024) NULL
    ,[verid] uniqueidentifier NOT NULL
    ,[isencrypted] bit NOT NULL -- DF [0]
    ,[readrolesid] varbinary(85) NULL
    ,[writerolesid] varbinary(85) NULL

    ,CONSTRAINT [pk_sysssispackages]
        PRIMARY KEY ([folderid], [name])
)
GO

ALTER TABLE [dbo].[sysssispackages] ADD CONSTRAINT [DF__sysssispackages]
    DEFAULT (((0))) FOR [packagetype]
GO

ALTER TABLE [dbo].[sysssispackages] ADD CONSTRAINT [DF__sysssispackages_2]
    DEFAULT (((0))) FOR [isencrypted]
GO
