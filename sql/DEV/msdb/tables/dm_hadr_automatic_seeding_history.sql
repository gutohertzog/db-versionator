USE [msdb]
GO

CREATE TABLE [dbo].[dm_hadr_automatic_seeding_history] (
    [start_time] datetime NOT NULL
    ,[completion_time] datetime NULL
    ,[ag_id] uniqueidentifier NOT NULL
    ,[ag_db_id] uniqueidentifier NOT NULL
    ,[ag_remote_replica_id] uniqueidentifier NOT NULL
    ,[operation_id] uniqueidentifier NOT NULL
    ,[is_source] bit NOT NULL
    ,[current_state] nvarchar(4000) NOT NULL
    ,[performed_seeding] bit NOT NULL
    ,[failure_state] int NULL
    ,[failure_state_desc] nvarchar(4000) NULL
    ,[error_code] int NULL
    ,[number_of_attempts] int NOT NULL
)
GO

GRANT SELECT ON [dm_hadr_automatic_seeding_history] TO [public]
GO
