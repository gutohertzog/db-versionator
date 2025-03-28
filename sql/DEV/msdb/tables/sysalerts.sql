USE [msdb]
GO

CREATE TABLE [dbo].[sysalerts] (
    [id] int NOT NULL IDENTITY(1,1)
    ,[name] sysname NOT NULL
    ,[event_source] nvarchar(100) NOT NULL
    ,[event_category_id] int NULL
    ,[event_id] int NULL
    ,[message_id] int NOT NULL
    ,[severity] int NOT NULL
    ,[enabled] tinyint NOT NULL
    ,[delay_between_responses] int NOT NULL
    ,[last_occurrence_date] int NOT NULL
    ,[last_occurrence_time] int NOT NULL
    ,[last_response_date] int NOT NULL
    ,[last_response_time] int NOT NULL
    ,[notification_message] nvarchar(512) NULL
    ,[include_event_description] tinyint NOT NULL
    ,[database_name] nvarchar(512) NULL
    ,[event_description_keyword] nvarchar(100) NULL
    ,[occurrence_count] int NOT NULL
    ,[count_reset_date] int NOT NULL
    ,[count_reset_time] int NOT NULL
    ,[job_id] uniqueidentifier NOT NULL
    ,[has_notification] int NOT NULL
    ,[flags] int NOT NULL
    ,[performance_condition] nvarchar(512) NULL
    ,[category_id] int NOT NULL
)
GO

GRANT SELECT ON [sysalerts] TO [SQLAgentOperatorRole]
GO
