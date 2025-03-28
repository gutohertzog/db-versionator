USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_computers_stub] (
    [id] int NOT NULL IDENTITY(1,1)
    ,[virtual_server_name] sysname NOT NULL
    ,[physical_server_name] sysname NOT NULL
    ,[is_clustered_server] int NULL
    ,[num_processors] int NULL
    ,[cpu_name] nvarchar(128) NULL
    ,[cpu_caption] nvarchar(128) NULL
    ,[cpu_family] nvarchar(128) NULL
    ,[cpu_architecture] nvarchar(64) NULL
    ,[cpu_max_clock_speed] decimal(10, 0) NULL
    ,[cpu_clock_speed] decimal(10, 0) NULL
    ,[l2_cache_size] decimal(10, 0) NULL
    ,[l3_cache_size] decimal(10, 0) NULL
    ,[urn] nvarchar(4000) NULL
    ,[powershell_path] nvarchar(4000) NULL
    ,[processing_time] datetimeoffset NULL
    ,[batch_time] datetimeoffset NULL
    ,[percent_total_cpu_utilization] real NULL
)
GO
