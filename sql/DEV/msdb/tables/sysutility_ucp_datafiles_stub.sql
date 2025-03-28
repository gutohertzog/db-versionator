USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_datafiles_stub] (
    [urn] nvarchar(1500) NULL
    ,[powershell_path] nvarchar(MAX) NULL
    ,[processing_time] datetimeoffset NULL
    ,[batch_time] datetimeoffset NULL
    ,[server_instance_name] sysname NOT NULL
    ,[database_name] sysname NOT NULL
    ,[filegroup_name] sysname NOT NULL
    ,[parent_urn] nvarchar(780) NULL
    ,[physical_server_name] sysname NOT NULL
    ,[volume_name] sysname NOT NULL
    ,[volume_device_id] sysname NOT NULL
    ,[Growth] real NULL
    ,[GrowthType] smallint NULL
    ,[MaxSize] real NULL
    ,[Name] nvarchar(128) NULL
    ,[Size] real NULL
    ,[UsedSpace] real NULL
    ,[FileName] nvarchar(260) NULL
    ,[VolumeFreeSpace] bigint NULL
    ,[available_space] real NULL
)
GO
