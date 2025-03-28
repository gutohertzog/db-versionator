USE [msdb]
GO

CREATE TABLE [dbo].[sysjobservers] (
    [job_id] uniqueidentifier NOT NULL
    ,[server_id] int NOT NULL
    ,[last_run_outcome] tinyint NOT NULL
    ,[last_outcome_message] nvarchar(4000) NULL
    ,[last_run_date] int NOT NULL
    ,[last_run_time] int NOT NULL
    ,[last_run_duration] int NOT NULL
)
GO

GRANT SELECT, UPDATE ON [sysjobservers] TO [TargetServersRole]
GO
