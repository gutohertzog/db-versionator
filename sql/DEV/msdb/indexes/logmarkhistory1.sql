USE [msdb]
GO

CREATE NONCLUSTERED INDEX [logmarkhistory1] ON [dbo].[logmarkhistory]
(
    [database_name],
    [mark_name]
)
GO
