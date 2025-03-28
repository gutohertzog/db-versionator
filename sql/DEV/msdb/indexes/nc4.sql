USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc4] ON [dbo].[sysjobs]
(
    [owner_sid]
)
GO
