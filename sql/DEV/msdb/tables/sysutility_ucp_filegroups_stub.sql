USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_filegroups_stub] (
    [urn] nvarchar(780) NULL
    ,[powershell_path] nvarchar(MAX) NULL
    ,[processing_time] datetimeoffset NULL
    ,[batch_time] datetimeoffset NULL
    ,[server_instance_name] sysname NOT NULL
    ,[database_name] sysname NOT NULL
    ,[parent_urn] nvarchar(512) NULL
    ,[Name] nvarchar(128) NULL
)
GO
