USE [msdb]
GO

CREATE NONCLUSTERED INDEX [IX_sysmanagement_shared_server_groups_name] ON [dbo].[sysmanagement_shared_server_groups_internal]
(
    [name]
)
GO
