USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_policy_target_conditions_internal] (
    [rollup_object_type] int NOT NULL -- PK
    ,[target_type] int NOT NULL -- PK
    ,[resource_type] int NOT NULL -- PK
    ,[utilization_type] int NOT NULL -- PK
    ,[facet_name] sysname NOT NULL -- PK
    ,[attribute_name] sysname NOT NULL -- PK
    ,[operator_type] int NOT NULL
    ,[property_name] sysname NOT NULL

    ,CONSTRAINT [PK_sysutility_ucp_policy_target_condition_internal_type]
        PRIMARY KEY ([rollup_object_type], [resource_type], [target_type], [utilization_type], [facet_name], [attribute_name])
)
GO

GRANT SELECT ON [sysutility_ucp_policy_target_conditions_internal] TO [UtilityCMRReader]
GO
