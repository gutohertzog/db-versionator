USE [msdb]
GO

CREATE NONCLUSTERED INDEX [restorefilegroupRestoreHistoryId] ON [dbo].[restorefilegroup]
(
    [restore_history_id]
)
GO
