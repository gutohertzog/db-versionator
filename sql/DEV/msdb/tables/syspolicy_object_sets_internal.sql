USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_object_sets_internal] (
    [object_set_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[object_set_name] sysname NOT NULL -- UK
    ,[facet_id] int NULL -- FK [syspolicy_management_facets]
    ,[is_system] bit NOT NULL -- DF [0]

    ,CONSTRAINT [PK_syspolicy_object_sets]
        PRIMARY KEY ([object_set_id])

    ,CONSTRAINT [UQ_syspolicy_object_sets_name]
        UNIQUE CLUSTERED ([object_set_name], [object_set_name])

    ,CONSTRAINT [FK_syspolicy_object_sets_syspolicy_management_facets]
        FOREIGN KEY ([facet_id])
        REFERENCES [dbo].[syspolicy_management_facets] ([management_facet_id])
)
GO

ALTER TABLE [dbo].[syspolicy_object_sets_internal] ADD CONSTRAINT [DF__syspolicy__is_sy__3D491139]
    DEFAULT (((0))) FOR [is_system]
GO
