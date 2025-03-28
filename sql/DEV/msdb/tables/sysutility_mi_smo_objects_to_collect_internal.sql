USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_mi_smo_objects_to_collect_internal] (
    [object_type] int NOT NULL -- PK
    ,[sfc_query] nvarchar(MAX) NOT NULL

    ,CONSTRAINT [PK__sysutili__077EA9652ADDC410]
        PRIMARY KEY ([object_type])
)
GO

GRANT SELECT ON [sysutility_mi_smo_objects_to_collect_internal] TO [UtilityIMRReader]
GO
