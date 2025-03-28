USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_monitor_error_detail] (
    [agent_id] uniqueidentifier NOT NULL
    ,[agent_type] tinyint NOT NULL
    ,[session_id] int NOT NULL
    ,[database_name] sysname NULL
    ,[sequence_number] int NOT NULL
    ,[log_time] datetime NOT NULL
    ,[log_time_utc] datetime NOT NULL
    ,[message] nvarchar(4000) NOT NULL
    ,[source] nvarchar(4000) NOT NULL
    ,[help_url] nvarchar(4000) NOT NULL
)
GO
