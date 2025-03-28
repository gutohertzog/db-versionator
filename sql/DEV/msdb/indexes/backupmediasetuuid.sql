USE [msdb]
GO

CREATE NONCLUSTERED INDEX [backupmediasetuuid] ON [dbo].[backupmediaset]
(
    [media_uuid]
)
GO
