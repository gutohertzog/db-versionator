USE [msdb]
GO

CREATE TABLE [dbo].[sysdbmaintplan_databases] (
    [plan_id] uniqueidentifier NOT NULL -- UK FK [sysdbmaintplans]
    ,[database_name] sysname NOT NULL -- UK

    ,CONSTRAINT [UQ__sysdbmai__AEEEF1DB6E92CE7C]
        UNIQUE CLUSTERED ([plan_id], [plan_id], [database_name])

    ,CONSTRAINT [FK__sysdbmain__plan___4DE98D56]
        FOREIGN KEY ([plan_id])
        REFERENCES [dbo].[sysdbmaintplans] ([plan_id])
)
GO
