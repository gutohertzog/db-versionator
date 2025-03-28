USE [msdb]
GO

CREATE TABLE [dbo].[systargetservergroups] (
    [servergroup_id] int NOT NULL IDENTITY(1,1)
    ,[name] sysname NOT NULL
)
GO
