USE [msdb]
GO

CREATE TABLE [dbo].[msdb_version] (
    [id] int NOT NULL IDENTITY(1,1)
    ,[version_string] nvarchar(255) NOT NULL
    ,[version_major] int NOT NULL
    ,[version_minor] int NOT NULL
    ,[version_build] int NOT NULL
    ,[version_revision] int NOT NULL
    ,[script_hash] uniqueidentifier NULL
    ,[upgrade_script_completed] bit NOT NULL -- DF [1]
)
GO

ALTER TABLE [dbo].[msdb_version] ADD CONSTRAINT [DF__msdb_vers__upgra__239E4DCF]
    DEFAULT (((1))) FOR [upgrade_script_completed]
GO
