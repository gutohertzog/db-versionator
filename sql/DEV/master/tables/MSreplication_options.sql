USE [master]
GO

CREATE TABLE [dbo].[MSreplication_options] (
    [optname] sysname NOT NULL
    ,[value] bit NOT NULL
    ,[major_version] int NOT NULL
    ,[minor_version] int NOT NULL
    ,[revision] int NOT NULL
    ,[install_failures] int NOT NULL
)
GO
