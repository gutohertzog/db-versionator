USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc2] ON [dbo].[sysdownloadlist]
(
    [object_id]
)
GO
