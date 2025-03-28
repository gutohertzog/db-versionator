USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_execution_internal] (
    [policy_id] int NULL
    ,[synchronous] bit NULL
    ,[event_data] xml NULL
)
GO
