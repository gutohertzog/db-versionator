USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_dac_file_space_health_internal] (
    [dac_name] sysname NOT NULL -- PK
    ,[dac_server_instance_name] sysname NOT NULL -- PK
    ,[fg_name] sysname NOT NULL -- PK
    ,[over_utilized_count] int NOT NULL -- DF [0]
    ,[under_utilized_count] int NOT NULL -- DF [0]
    ,[file_type] int NOT NULL
    ,[set_number] int NOT NULL -- PK DF [0]
    ,[processing_time] datetimeoffset NOT NULL -- DF [sysdatetimeoffset()]

    ,CONSTRAINT [PK_sysutility_ucp_dac_file_space_health_internal_name]
        PRIMARY KEY ([set_number], [dac_server_instance_name], [dac_name], [fg_name])
)
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_file_space_health_internal] ADD CONSTRAINT [DF__sysutilit__over___770B9E7A]
    DEFAULT (((0))) FOR [over_utilized_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_file_space_health_internal] ADD CONSTRAINT [DF__sysutilit__proce__79E80B25]
    DEFAULT ((sysdatetimeoffset())) FOR [processing_time]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_file_space_health_internal] ADD CONSTRAINT [DF__sysutilit__set_n__78F3E6EC]
    DEFAULT (((0))) FOR [set_number]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_file_space_health_internal] ADD CONSTRAINT [DF__sysutilit__under__77FFC2B3]
    DEFAULT (((0))) FOR [under_utilized_count]
GO

GRANT SELECT ON [sysutility_ucp_dac_file_space_health_internal] TO [UtilityCMRReader]
GO
