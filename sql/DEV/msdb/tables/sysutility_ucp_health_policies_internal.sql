USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_health_policies_internal] (
    [health_policy_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[policy_name] sysname NOT NULL
    ,[rollup_object_urn] nvarchar(4000) NOT NULL
    ,[rollup_object_type] int NOT NULL
    ,[target_type] int NOT NULL
    ,[resource_type] int NOT NULL
    ,[utilization_type] int NOT NULL
    ,[utilization_threshold] float NOT NULL
    ,[is_global_policy] bit NULL -- DF [0]

    ,CONSTRAINT [PK_sysutility_ucp_policies_internal_id]
        PRIMARY KEY ([health_policy_id])
)
GO

ALTER TABLE [dbo].[sysutility_ucp_health_policies_internal] ADD CONSTRAINT [DF__sysutilit__is_gl__3CDEFCE5]
    DEFAULT (((0))) FOR [is_global_policy]
GO

GRANT SELECT ON [sysutility_ucp_health_policies_internal] TO [UtilityCMRReader]
GO
