USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_policy_check_conditions_internal] (
    [target_type] int NOT NULL -- PK
    ,[resource_type] int NOT NULL -- PK
    ,[utilization_type] int NOT NULL -- PK
    ,[facet_name] sysname NOT NULL -- PK
    ,[attribute_name] sysname NOT NULL -- PK
    ,[operator_type] int NOT NULL
    ,[property_name] sysname NOT NULL

    ,CONSTRAINT [PK_sysutility_ucp_policy_check_condition_internal_type]
        PRIMARY KEY ([resource_type], [target_type], [utilization_type], [facet_name], [attribute_name])
)
GO

GRANT SELECT ON [sysutility_ucp_policy_check_conditions_internal] TO [UtilityCMRReader]
GO
