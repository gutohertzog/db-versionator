USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_volumes_stub] (
    [ID] int NOT NULL IDENTITY(1,1)
    ,[virtual_server_name] sysname NOT NULL
    ,[physical_server_name] sysname NOT NULL
    ,[volume_device_id] sysname NOT NULL
    ,[volume_name] sysname NOT NULL
    ,[total_space_available] real NULL
    ,[free_space] real NULL
    ,[total_space_utilized] real NULL
    ,[percent_total_space_utilization] real NULL
    ,[processing_time] datetimeoffset NULL
    ,[batch_time] datetimeoffset NULL
    ,[powershell_path] nvarchar(4000) NULL
)
GO
