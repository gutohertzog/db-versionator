USE [msdb]
GO

CREATE TABLE [dbo].[systaskids] (
    [task_id] int NOT NULL IDENTITY(1,1)
    ,[job_id] uniqueidentifier NOT NULL
)
GO
