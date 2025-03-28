USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_mi_volume_space_health_internal] (
    [physical_server_name] sysname NOT NULL
    ,[server_instance_name] sysname NOT NULL -- PK
    ,[volume_device_id] sysname NOT NULL -- PK
    ,[health_state] int NOT NULL
    ,[set_number] int NOT NULL -- PK DF [0]
    ,[processing_time] datetimeoffset NOT NULL -- DF [sysdatetimeoffset()]

    ,CONSTRAINT [PK_sysutility_ucp_mi_volume_space_health_internal_name]
        PRIMARY KEY ([set_number], [server_instance_name], [volume_device_id])
)
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_volume_space_health_internal] ADD CONSTRAINT [DF__sysutilit__proce__7DB89C09]
    DEFAULT ((sysdatetimeoffset())) FOR [processing_time]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_volume_space_health_internal] ADD CONSTRAINT [DF__sysutilit__set_n__7CC477D0]
    DEFAULT (((0))) FOR [set_number]
GO

GRANT SELECT ON [sysutility_ucp_mi_volume_space_health_internal] TO [UtilityCMRReader]
GO
