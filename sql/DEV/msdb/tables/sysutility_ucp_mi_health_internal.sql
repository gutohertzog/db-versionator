USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_mi_health_internal] (
    [mi_name] sysname NOT NULL -- PK
    ,[is_volume_space_over_utilized] int NOT NULL -- DF [0]
    ,[is_volume_space_under_utilized] int NOT NULL -- DF [0]
    ,[is_computer_processor_over_utilized] int NOT NULL -- DF [0]
    ,[is_computer_processor_under_utilized] int NOT NULL -- DF [0]
    ,[is_file_space_over_utilized] int NOT NULL -- DF [0]
    ,[is_file_space_under_utilized] int NOT NULL -- DF [0]
    ,[is_mi_processor_over_utilized] int NOT NULL -- DF [0]
    ,[is_mi_processor_under_utilized] int NOT NULL -- DF [0]
    ,[is_policy_overridden] bit NOT NULL -- DF [0]
    ,[set_number] int NOT NULL -- PK DF [0]
    ,[processing_time] datetimeoffset NOT NULL -- DF [sysdatetimeoffset()]

    ,CONSTRAINT [PK_sysutility_ucp_mi_health_internal_name]
        PRIMARY KEY ([set_number], [mi_name])
)
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__is_co__3414ACBA]
    DEFAULT (((0))) FOR [is_computer_processor_over_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__is_co__3508D0F3]
    DEFAULT (((0))) FOR [is_computer_processor_under_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__is_fi__35FCF52C]
    DEFAULT (((0))) FOR [is_file_space_over_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__is_fi__36F11965]
    DEFAULT (((0))) FOR [is_file_space_under_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__is_mi__37E53D9E]
    DEFAULT (((0))) FOR [is_mi_processor_over_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__is_mi__38D961D7]
    DEFAULT (((0))) FOR [is_mi_processor_under_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__is_po__39CD8610]
    DEFAULT (((0))) FOR [is_policy_overridden]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__is_vo__322C6448]
    DEFAULT (((0))) FOR [is_volume_space_over_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__is_vo__33208881]
    DEFAULT (((0))) FOR [is_volume_space_under_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__proce__3BB5CE82]
    DEFAULT ((sysdatetimeoffset())) FOR [processing_time]
GO

ALTER TABLE [dbo].[sysutility_ucp_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__set_n__3AC1AA49]
    DEFAULT (((0))) FOR [set_number]
GO

GRANT SELECT ON [sysutility_ucp_mi_health_internal] TO [UtilityCMRReader]
GO
