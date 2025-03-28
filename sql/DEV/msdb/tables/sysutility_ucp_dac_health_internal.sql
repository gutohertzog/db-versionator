USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_dac_health_internal] (
    [dac_name] sysname NOT NULL -- PK
    ,[dac_server_instance_name] sysname NOT NULL -- PK
    ,[is_volume_space_over_utilized] int NOT NULL -- DF [0]
    ,[is_volume_space_under_utilized] int NOT NULL -- DF [0]
    ,[is_computer_processor_over_utilized] int NOT NULL -- DF [0]
    ,[is_computer_processor_under_utilized] int NOT NULL -- DF [0]
    ,[is_file_space_over_utilized] int NOT NULL -- DF [0]
    ,[is_file_space_under_utilized] int NOT NULL -- DF [0]
    ,[is_dac_processor_over_utilized] int NOT NULL -- DF [0]
    ,[is_dac_processor_under_utilized] int NOT NULL -- DF [0]
    ,[is_policy_overridden] bit NOT NULL -- DF [0]
    ,[set_number] int NOT NULL -- PK DF [0]
    ,[processing_time] datetimeoffset NOT NULL -- DF [sysdatetimeoffset()]

    ,CONSTRAINT [PK_sysutility_ucp_dac_health_internal_name]
        PRIMARY KEY ([set_number], [dac_server_instance_name], [dac_name])
)
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__is_co__27AED5D5]
    DEFAULT (((0))) FOR [is_computer_processor_over_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__is_co__28A2FA0E]
    DEFAULT (((0))) FOR [is_computer_processor_under_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__is_da__2B7F66B9]
    DEFAULT (((0))) FOR [is_dac_processor_over_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__is_da__2C738AF2]
    DEFAULT (((0))) FOR [is_dac_processor_under_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__is_fi__29971E47]
    DEFAULT (((0))) FOR [is_file_space_over_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__is_fi__2A8B4280]
    DEFAULT (((0))) FOR [is_file_space_under_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__is_po__2D67AF2B]
    DEFAULT (((0))) FOR [is_policy_overridden]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__is_vo__25C68D63]
    DEFAULT (((0))) FOR [is_volume_space_over_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__is_vo__26BAB19C]
    DEFAULT (((0))) FOR [is_volume_space_under_utilized]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__proce__2F4FF79D]
    DEFAULT ((sysdatetimeoffset())) FOR [processing_time]
GO

ALTER TABLE [dbo].[sysutility_ucp_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__set_n__2E5BD364]
    DEFAULT (((0))) FOR [set_number]
GO

GRANT SELECT ON [sysutility_ucp_dac_health_internal] TO [UtilityCMRReader]
GO
