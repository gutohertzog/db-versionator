USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_mi_smo_properties_to_collect_internal] (
    [object_type] int NOT NULL -- PK FK [sysutility_mi_smo_objects_to_collect_internal]
    ,[property_name] nvarchar(80) NOT NULL -- PK

    ,CONSTRAINT [PK__sysutili__AC2D3E992ED70707]
        PRIMARY KEY ([object_type], [property_name])

    ,CONSTRAINT [FK_sysutility_mi_smo_properties]
        FOREIGN KEY ([object_type])
        REFERENCES [dbo].[sysutility_mi_smo_objects_to_collect_internal] ([object_type])
)
GO

GRANT SELECT ON [sysutility_mi_smo_properties_to_collect_internal] TO [UtilityIMRReader]
GO
