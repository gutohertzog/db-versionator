USE [msdb]
GO

CREATE NONCLUSTERED INDEX [restorefileRestoreHistoryId] ON [dbo].[restorefile]
(
    [restore_history_id]
)
GO
