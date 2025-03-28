USE [msdb]
GO

CREATE TABLE [dbo].[sysjobs] (
    [job_id] uniqueidentifier NOT NULL
    ,[originating_server_id] int NOT NULL
    ,[name] sysname NOT NULL
    ,[enabled] tinyint NOT NULL
    ,[description] nvarchar(512) NULL
    ,[start_step_id] int NOT NULL
    ,[category_id] int NOT NULL
    ,[owner_sid] varbinary(85) NOT NULL
    ,[notify_level_eventlog] int NOT NULL
    ,[notify_level_email] int NOT NULL
    ,[notify_level_netsend] int NOT NULL
    ,[notify_level_page] int NOT NULL
    ,[notify_email_operator_id] int NOT NULL
    ,[notify_netsend_operator_id] int NOT NULL
    ,[notify_page_operator_id] int NOT NULL
    ,[delete_level] int NOT NULL
    ,[date_created] datetime NOT NULL
    ,[date_modified] datetime NOT NULL
    ,[version_number] int NOT NULL
)
GO

GRANT SELECT ON [sysjobs] TO [TargetServersRole]
GO
