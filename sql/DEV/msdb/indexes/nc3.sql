USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc3] ON [dbo].[sysjobs]
(
    [category_id]
)
GO
