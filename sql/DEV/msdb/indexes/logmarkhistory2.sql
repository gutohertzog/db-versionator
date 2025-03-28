USE [msdb]
GO

CREATE NONCLUSTERED INDEX [logmarkhistory2] ON [dbo].[logmarkhistory]
(
    [database_name],
    [lsn]
)
GO
