USE [msdb]
GO

CREATE CLUSTERED INDEX [IX_sysmanagement_shared_registered_servers_clustGroupID] ON [dbo].[sysmanagement_shared_registered_servers_internal]
(
    [server_group_id]
)
GO
