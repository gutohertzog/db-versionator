USE [msdb]
GO

CREATE TABLE [dbo].[syssubsystems] (
    [subsystem_id] int NOT NULL
    ,[subsystem] nvarchar(40) NOT NULL
    ,[description_id] int NULL
    ,[subsystem_dll] nvarchar(255) NULL
    ,[agent_exe] nvarchar(255) NULL
    ,[start_entry_point] nvarchar(30) NULL
    ,[event_entry_point] nvarchar(30) NULL
    ,[stop_entry_point] nvarchar(30) NULL
    ,[max_worker_threads] int NULL
)
GO

GRANT SELECT ON [syssubsystems] TO [TargetServersRole]
GO
