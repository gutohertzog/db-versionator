USE [msdb]
GO

CREATE NONCLUSTERED INDEX [backupsetuuid] ON [dbo].[backupset]
(
    [backup_set_uuid]
)
GO
