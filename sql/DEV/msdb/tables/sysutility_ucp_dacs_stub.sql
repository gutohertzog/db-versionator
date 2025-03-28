USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_dacs_stub] (
    [dac_id] int NOT NULL IDENTITY(1,1)
    ,[physical_server_name] sysname NOT NULL
    ,[server_instance_name] sysname NOT NULL
    ,[dac_name] sysname NOT NULL
    ,[dac_deploy_date] datetime NULL
    ,[dac_description] nvarchar(4000) NULL
    ,[urn] nvarchar(4000) NULL
    ,[powershell_path] nvarchar(4000) NULL
    ,[processing_time] datetimeoffset NULL
    ,[batch_time] datetimeoffset NULL
    ,[dac_percent_total_cpu_utilization] real NULL
)
GO
