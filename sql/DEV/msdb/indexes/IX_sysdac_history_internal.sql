USE [msdb]
GO

CREATE NONCLUSTERED INDEX [IX_sysdac_history_internal] ON [dbo].[sysdac_history_internal]
(
    [sequence_id],
    [action_status]
)
GO
