USE [msdb]
GO

CREATE TABLE [dbo].[sysjobactivity] (
    [session_id] int NOT NULL -- FK [syssessions]
    ,[job_id] uniqueidentifier NOT NULL -- FK [sysjobs]
    ,[run_requested_date] datetime NULL
    ,[run_requested_source] sysname NULL
    ,[queued_date] datetime NULL
    ,[start_execution_date] datetime NULL
    ,[last_executed_step_id] int NULL
    ,[last_executed_step_date] datetime NULL
    ,[stop_execution_date] datetime NULL
    ,[job_history_id] int NULL
    ,[next_scheduled_run_date] datetime NULL

    ,CONSTRAINT [FK__sysjobact__job_i__66603565]
        FOREIGN KEY ([job_id])
        REFERENCES [dbo].[sysjobs] ([job_id])

    ,CONSTRAINT [FK__sysjobact__sessi__656C112C]
        FOREIGN KEY ([session_id])
        REFERENCES [dbo].[syssessions] ([session_id])
)
GO
