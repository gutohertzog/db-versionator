USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_mi_configuration_internal] (
    [configuration_id] int NOT NULL -- PK
    ,[ucp_instance_name] sysname NULL
    ,[mdw_database_name] sysname NULL

    ,CONSTRAINT [pk_sysutility_mi_configuration_internal_configuration_id]
        PRIMARY KEY ([configuration_id])
)
GO

GRANT SELECT ON [sysutility_mi_configuration_internal] TO [UtilityIMRReader]
GO
