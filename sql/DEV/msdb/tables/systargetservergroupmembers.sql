USE [msdb]
GO

CREATE TABLE [dbo].[systargetservergroupmembers] (
    [servergroup_id] int NOT NULL
    ,[server_id] int NOT NULL
)
GO
