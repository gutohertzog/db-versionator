USE [msdb]
GO

CREATE CLUSTERED INDEX [IX_sysmanagement_shared_server_groups_clustParentGroupID] ON [dbo].[sysmanagement_shared_server_groups_internal]
(
    [parent_id]
)
GO
