USE [msdb]
GO

CREATE NONCLUSTERED INDEX [backupsetMediaSetId] ON [dbo].[backupset]
(
    [media_set_id]
)
GO
