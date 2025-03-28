USE [msdb]
GO

CREATE TABLE [dbo].[external_libraries_installed] (
    [db_id] int NOT NULL
    ,[principal_id] int NOT NULL
    ,[language_id] int NOT NULL
    ,[external_library_id] int NOT NULL
    ,[name] nvarchar(128) NOT NULL
    ,[mdversion] binary NOT NULL
)
GO

GRANT SELECT ON [external_libraries_installed] TO [public]
GO
