USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_computer_cpu_health_internal] (
    [physical_server_name] sysname NOT NULL -- PK
    ,[health_state] int NOT NULL
    ,[set_number] int NOT NULL -- PK DF [0]
    ,[processing_time] datetimeoffset NOT NULL -- DF [sysdatetimeoffset()]

    ,CONSTRAINT [PK_sysutility_ucp_computer_cpu_health_internal_name]
        PRIMARY KEY ([set_number], [physical_server_name])
)
GO

ALTER TABLE [dbo].[sysutility_ucp_computer_cpu_health_internal] ADD CONSTRAINT [DF__sysutilit__proce__01892CED]
    DEFAULT ((sysdatetimeoffset())) FOR [processing_time]
GO

ALTER TABLE [dbo].[sysutility_ucp_computer_cpu_health_internal] ADD CONSTRAINT [DF__sysutilit__set_n__009508B4]
    DEFAULT (((0))) FOR [set_number]
GO
