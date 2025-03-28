USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] (
    [mi_count] int NOT NULL -- DF [0]
    ,[mi_healthy_count] int NOT NULL -- DF [0]
    ,[mi_unhealthy_count] int NOT NULL -- DF [0]
    ,[mi_over_utilize_count] int NOT NULL -- DF [0]
    ,[mi_under_utilize_count] int NOT NULL -- DF [0]
    ,[mi_on_over_utilized_computer_count] int NOT NULL -- DF [0]
    ,[mi_on_under_utilized_computer_count] int NOT NULL -- DF [0]
    ,[mi_with_files_on_over_utilized_volume_count] int NOT NULL -- DF [0]
    ,[mi_with_files_on_under_utilized_volume_count] int NOT NULL -- DF [0]
    ,[mi_with_over_utilized_file_count] int NOT NULL -- DF [0]
    ,[mi_with_under_utilized_file_count] int NOT NULL -- DF [0]
    ,[mi_with_over_utilized_processor_count] int NOT NULL -- DF [0]
    ,[mi_with_under_utilized_processor_count] int NOT NULL -- DF [0]
    ,[set_number] int NOT NULL -- DF [0]
)
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_co__168449D3]
    DEFAULT (((0))) FOR [mi_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_he__17786E0C]
    DEFAULT (((0))) FOR [mi_healthy_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_on__1B48FEF0]
    DEFAULT (((0))) FOR [mi_on_over_utilized_computer_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_on__1C3D2329]
    DEFAULT (((0))) FOR [mi_on_under_utilized_computer_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_ov__1960B67E]
    DEFAULT (((0))) FOR [mi_over_utilize_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_un__186C9245]
    DEFAULT (((0))) FOR [mi_unhealthy_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_un__1A54DAB7]
    DEFAULT (((0))) FOR [mi_under_utilize_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_wi__1D314762]
    DEFAULT (((0))) FOR [mi_with_files_on_over_utilized_volume_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_wi__1E256B9B]
    DEFAULT (((0))) FOR [mi_with_files_on_under_utilized_volume_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_wi__1F198FD4]
    DEFAULT (((0))) FOR [mi_with_over_utilized_file_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_wi__200DB40D]
    DEFAULT (((0))) FOR [mi_with_under_utilized_file_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_wi__2101D846]
    DEFAULT (((0))) FOR [mi_with_over_utilized_processor_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__mi_wi__21F5FC7F]
    DEFAULT (((0))) FOR [mi_with_under_utilized_processor_count]
GO

ALTER TABLE [dbo].[sysutility_ucp_aggregated_mi_health_internal] ADD CONSTRAINT [DF__sysutilit__set_n__22EA20B8]
    DEFAULT (((0))) FOR [set_number]
GO

GRANT SELECT ON [sysutility_ucp_aggregated_mi_health_internal] TO [UtilityCMRReader]
GO
