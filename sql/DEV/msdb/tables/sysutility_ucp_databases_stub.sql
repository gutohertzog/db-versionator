USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_databases_stub] (
    [urn] nvarchar(512) NULL
    ,[powershell_path] nvarchar(MAX) NULL
    ,[processing_time] datetimeoffset NULL
    ,[batch_time] datetimeoffset NULL
    ,[server_instance_name] sysname NOT NULL
    ,[parent_urn] nvarchar(320) NULL
    ,[Collation] nvarchar(128) NULL
    ,[CompatibilityLevel] smallint NULL
    ,[CreateDate] datetime NULL
    ,[EncryptionEnabled] bit NULL
    ,[Name] nvarchar(128) NULL
    ,[RecoveryModel] smallint NULL
    ,[Trustworthy] bit NULL
    ,[state] tinyint NULL
)
GO
