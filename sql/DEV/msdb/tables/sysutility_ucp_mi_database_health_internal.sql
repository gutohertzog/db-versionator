USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_mi_database_health_internal] (
    [server_instance_name] sysname NOT NULL -- PK
    ,[database_name] sysname NOT NULL -- PK
    ,[over_utilized_count] int NOT NULL -- DF [0]
    ,[under_utilized_count] int NOT NULL -- DF [0]
    ,[set_number] int NOT NULL -- PK DF [0]
    ,[processing_time] datetimeoffset NOT NULL -- DF [sysdatetimeoffset()]

    ,CONSTRAINT [PK_sysutility_ucp_mi_database_health_internal_name]
        PRIMARY KEY ([set_number], [server_instance_name], [database_name])
)
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_database_health_internal] ADD CONSTRAINT [DF__sysutilit__over___7152C524]
    DEFAULT (((0))) FOR [over_utilized_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_database_health_internal] ADD CONSTRAINT [DF__sysutilit__proce__742F31CF]
    DEFAULT ((sysdatetimeoffset())) FOR [processing_time]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_database_health_internal] ADD CONSTRAINT [DF__sysutilit__set_n__733B0D96]
    DEFAULT (((0))) FOR [set_number]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_database_health_internal] ADD CONSTRAINT [DF__sysutilit__under__7246E95D]
    DEFAULT (((0))) FOR [under_utilized_count]
GO

GRANT SELECT ON [sysutility_ucp_mi_database_health_internal] TO [UtilityCMRReader]
GO
