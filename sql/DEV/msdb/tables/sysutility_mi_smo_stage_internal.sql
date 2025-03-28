USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_mi_smo_stage_internal] (
    [object_type] int NOT NULL
    ,[urn] nvarchar(4000) NOT NULL
    ,[property_name] nvarchar(128) NOT NULL
    ,[property_value] sql_variant NULL
    ,[server_instance_name] sysname NULL
    ,[physical_server_name] sysname NULL
)
GO

GRANT SELECT ON [sysutility_mi_smo_stage_internal] TO [UtilityIMRReader]
GRANT DELETE, INSERT ON [sysutility_mi_smo_stage_internal] TO [UtilityIMRWriter]
GO
