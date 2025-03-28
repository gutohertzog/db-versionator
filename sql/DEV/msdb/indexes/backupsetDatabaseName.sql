USE [msdb]
GO

CREATE NONCLUSTERED INDEX [backupsetDatabaseName] ON [dbo].[backupset]
(
    [database_name]
)
INCLUDE
(
    [backup_set_id],
    [media_set_id]
)
GO
