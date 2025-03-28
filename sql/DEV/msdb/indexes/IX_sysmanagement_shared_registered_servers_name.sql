USE [msdb]
GO

CREATE NONCLUSTERED INDEX [IX_sysmanagement_shared_registered_servers_name] ON [dbo].[sysmanagement_shared_registered_servers_internal]
(
    [name]
)
GO
