USE [msdb]
GO

CREATE   VIEW [dbo].[sysmanagement_shared_registered_servers]
AS
(
    SELECT server_id, server_group_id, name, server_name, description, server_type
    FROM [msdb].[dbo].[sysmanagement_shared_registered_servers_internal]
)
GO

GRANT SELECT ON [sysmanagement_shared_registered_servers] TO [ServerGroupReaderRole]
GO
