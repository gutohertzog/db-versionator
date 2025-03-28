USE [msdb]
GO

CREATE NONCLUSTERED INDEX [backupmediafamilyuuid] ON [dbo].[backupmediafamily]
(
    [media_family_id]
)
GO
