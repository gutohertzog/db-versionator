USE [msdb]
GO

CREATE   VIEW [dbo].[sysutility_ucp_managed_instances]
AS
    SELECT
        instance_id,
        instance_name,
        virtual_server_name,
        date_created,
        created_by,
        agent_proxy_account,
        cache_directory,
        management_state
    FROM [dbo].[sysutility_ucp_managed_instances_internal]
GO

GRANT SELECT ON [sysutility_ucp_managed_instances] TO [UtilityCMRReader]
GO
