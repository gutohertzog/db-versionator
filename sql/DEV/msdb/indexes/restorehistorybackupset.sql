USE [msdb]
GO

CREATE NONCLUSTERED INDEX [restorehistorybackupset] ON [dbo].[restorehistory]
(
    [backup_set_id]
)
GO
