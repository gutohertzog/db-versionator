USE [msdb]
GO

CREATE TABLE [dbo].[sysjobschedules] (
    [schedule_id] int NULL -- FK [sysschedules]
    ,[job_id] uniqueidentifier NULL -- FK [sysjobs]
    ,[next_run_date] int NOT NULL -- DF [0]
    ,[next_run_time] int NOT NULL -- DF [0]

    ,CONSTRAINT [FK__sysjobsch__job_i__75A278F5]
        FOREIGN KEY ([job_id])
        REFERENCES [dbo].[sysjobs] ([job_id])

    ,CONSTRAINT [FK__sysjobsch__sched__74AE54BC]
        FOREIGN KEY ([schedule_id])
        REFERENCES [dbo].[sysschedules] ([schedule_id])
)
GO

ALTER TABLE [dbo].[sysjobschedules] ADD CONSTRAINT [DF__sysjobsch__next___76969D2E]
    DEFAULT (((0))) FOR [next_run_date]
GO

ALTER TABLE [dbo].[sysjobschedules] ADD CONSTRAINT [DF__sysjobsch__next___778AC167]
    DEFAULT (((0))) FOR [next_run_time]
GO
