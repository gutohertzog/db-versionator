USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_space_utilization_stub] (
    [processing_time] datetimeoffset NOT NULL
    ,[aggregation_type] tinyint NOT NULL
    ,[object_type] tinyint NOT NULL
    ,[virtual_server_name] sysname NOT NULL -- DF ['']
    ,[server_instance_name] sysname NOT NULL -- DF ['']
    ,[volume_device_id] sysname NOT NULL -- DF ['']
    ,[database_name] sysname NOT NULL -- DF ['']
    ,[filegroup_name] sysname NOT NULL -- DF ['']
    ,[dbfile_name] sysname NOT NULL -- DF ['']
    ,[used_space_bytes] real NULL
    ,[allocated_space_bytes] real NULL
    ,[total_space_bytes] real NULL
    ,[available_space_bytes] real NULL
)
GO

ALTER TABLE [dbo].[sysutility_ucp_space_utilization_stub] ADD CONSTRAINT [DF__sysutilit__datab__3E7D2C94]
    DEFAULT (('')) FOR [database_name]
GO

ALTER TABLE [dbo].[sysutility_ucp_space_utilization_stub] ADD CONSTRAINT [DF__sysutilit__dbfil__40657506]
    DEFAULT (('')) FOR [dbfile_name]
GO

ALTER TABLE [dbo].[sysutility_ucp_space_utilization_stub] ADD CONSTRAINT [DF__sysutilit__fileg__3F7150CD]
    DEFAULT (('')) FOR [filegroup_name]
GO

ALTER TABLE [dbo].[sysutility_ucp_space_utilization_stub] ADD CONSTRAINT [DF__sysutilit__serve__3C94E422]
    DEFAULT (('')) FOR [server_instance_name]
GO

ALTER TABLE [dbo].[sysutility_ucp_space_utilization_stub] ADD CONSTRAINT [DF__sysutilit__virtu__3BA0BFE9]
    DEFAULT (('')) FOR [virtual_server_name]
GO

ALTER TABLE [dbo].[sysutility_ucp_space_utilization_stub] ADD CONSTRAINT [DF__sysutilit__volum__3D89085B]
    DEFAULT (('')) FOR [volume_device_id]
GO
