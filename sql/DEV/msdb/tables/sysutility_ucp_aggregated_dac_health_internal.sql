USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] (
    [dac_count] int NOT NULL -- DF [0]
    ,[dac_healthy_count] int NOT NULL -- DF [0]
    ,[dac_unhealthy_count] int NOT NULL -- DF [0]
    ,[dac_over_utilize_count] int NOT NULL -- DF [0]
    ,[dac_under_utilize_count] int NOT NULL -- DF [0]
    ,[dac_on_over_utilized_computer_count] int NOT NULL -- DF [0]
    ,[dac_on_under_utilized_computer_count] int NOT NULL -- DF [0]
    ,[dac_with_files_on_over_utilized_volume_count] int NOT NULL -- DF [0]
    ,[dac_with_files_on_under_utilized_volume_count] int NOT NULL -- DF [0]
    ,[dac_with_over_utilized_file_count] int NOT NULL -- DF [0]
    ,[dac_with_under_utilized_file_count] int NOT NULL -- DF [0]
    ,[dac_with_over_utilized_processor_count] int NOT NULL -- DF [0]
    ,[dac_with_under_utilized_processor_count] int NOT NULL -- DF [0]
    ,[set_number] int NOT NULL -- DF [0]
)
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_c__08362A7C]
    DEFAULT (((0))) FOR [dac_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_h__092A4EB5]
    DEFAULT (((0))) FOR [dac_healthy_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_o__0B129727]
    DEFAULT (((0))) FOR [dac_over_utilize_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_o__0CFADF99]
    DEFAULT (((0))) FOR [dac_on_over_utilized_computer_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_o__0DEF03D2]
    DEFAULT (((0))) FOR [dac_on_under_utilized_computer_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_u__0A1E72EE]
    DEFAULT (((0))) FOR [dac_unhealthy_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_u__0C06BB60]
    DEFAULT (((0))) FOR [dac_under_utilize_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_w__0EE3280B]
    DEFAULT (((0))) FOR [dac_with_files_on_over_utilized_volume_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_w__0FD74C44]
    DEFAULT (((0))) FOR [dac_with_files_on_under_utilized_volume_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_w__10CB707D]
    DEFAULT (((0))) FOR [dac_with_over_utilized_file_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_w__11BF94B6]
    DEFAULT (((0))) FOR [dac_with_under_utilized_file_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_w__12B3B8EF]
    DEFAULT (((0))) FOR [dac_with_over_utilized_processor_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__dac_w__13A7DD28]
    DEFAULT (((0))) FOR [dac_with_under_utilized_processor_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_dac_health_internal] ADD CONSTRAINT [DF__sysutilit__set_n__149C0161]
    DEFAULT (((0))) FOR [set_number]
GO

GRANT SELECT ON [sysutility_ucp_aggregated_dac_health_internal] TO [UtilityCMRReader]
GO
