USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_mi_volumes_stage_internal] (
    [volume_device_id] sysname NOT NULL -- DF [N'']
    ,[volume_name] nvarchar(260) NOT NULL -- DF [N'']
    ,[capacity_mb] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[free_space_mb] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[server_instance_name] sysname NULL
    ,[virtual_server_name] sysname NULL
    ,[physical_server_name] sysname NULL
)
GO

ALTER TABLE [dbo].[sysutility_mi_volumes_stage_internal] ADD CONSTRAINT [DF__sysutilit__capac__086B34A6]
    DEFAULT (((0.0))) FOR [capacity_mb]
GO

ALTER TABLE [dbo].[sysutility_mi_volumes_stage_internal] ADD CONSTRAINT [DF__sysutilit__free___095F58DF]
    DEFAULT (((0.0))) FOR [free_space_mb]
GO

ALTER TABLE [dbo].[sysutility_mi_volumes_stage_internal] ADD CONSTRAINT [DF__sysutilit__volum__0682EC34]
    DEFAULT ((N'')) FOR [volume_device_id]
GO

ALTER TABLE [dbo].[sysutility_mi_volumes_stage_internal] ADD CONSTRAINT [DF__sysutilit__volum__0777106D]
    DEFAULT ((N'')) FOR [volume_name]
GO

GRANT SELECT ON [sysutility_mi_volumes_stage_internal] TO [UtilityIMRReader]
GRANT DELETE, INSERT ON [sysutility_mi_volumes_stage_internal] TO [UtilityIMRWriter]
GO
