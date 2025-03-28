USE [msdb]
GO

CREATE NONCLUSTERED INDEX [nc1] ON [dbo].[sysdownloadlist]
(
    [target_server],
    [job_id],
    [name],
    [server_id],
    [server_id]
)
GO
