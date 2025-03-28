USE [msdb]
GO

CREATE NONCLUSTERED INDEX [NC_sysjobschedules_schedule_id] ON [dbo].[sysjobschedules]
(
    [schedule_id]
)
GO
