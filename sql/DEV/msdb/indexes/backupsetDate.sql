USE [msdb]
GO

CREATE NONCLUSTERED INDEX [backupsetDate] ON [dbo].[backupset]
(
    [backup_finish_date]
)
GO
