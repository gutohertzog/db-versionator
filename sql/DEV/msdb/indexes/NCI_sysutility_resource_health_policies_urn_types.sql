USE [msdb]
GO

CREATE NONCLUSTERED INDEX [NCI_sysutility_resource_health_policies_urn_types] ON [dbo].[sysutility_ucp_health_policies_internal]
(
    [rollup_object_type],
    [target_type],
    [resource_type],
    [utilization_type],
    [policy_name]
)
INCLUDE
(
    [rollup_object_urn]
)
GO
