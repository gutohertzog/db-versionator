USE [msdb]
GO

CREATE TABLE [dbo].[sysdbmaintplan_jobs] (
    [plan_id] uniqueidentifier NOT NULL -- UK FK [sysdbmaintplans]
    ,[job_id] uniqueidentifier NOT NULL -- UK

    ,CONSTRAINT [UQ__sysdbmai__F87CA477FD5E37E5]
        UNIQUE CLUSTERED ([plan_id], [plan_id], [job_id])

    ,CONSTRAINT [FK__sysdbmain__plan___4B0D20AB]
        FOREIGN KEY ([plan_id])
        REFERENCES [dbo].[sysdbmaintplans] ([plan_id])
)
GO
