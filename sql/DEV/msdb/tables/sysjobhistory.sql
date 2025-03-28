USE [msdb]
GO

CREATE TABLE [dbo].[sysjobhistory] (
    [instance_id] int NOT NULL IDENTITY(1,1)
    ,[job_id] uniqueidentifier NOT NULL
    ,[step_id] int NOT NULL
    ,[step_name] sysname NOT NULL
    ,[sql_message_id] int NOT NULL
    ,[sql_severity] int NOT NULL
    ,[message] nvarchar(4000) NULL
    ,[run_status] int NOT NULL
    ,[run_date] int NOT NULL
    ,[run_time] int NOT NULL
    ,[run_duration] int NOT NULL
    ,[operator_id_emailed] int NOT NULL
    ,[operator_id_netsent] int NOT NULL
    ,[operator_id_paged] int NOT NULL
    ,[retries_attempted] int NOT NULL
    ,[server] sysname NOT NULL
)
GO
