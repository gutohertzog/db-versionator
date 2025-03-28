USE [msdb]
GO

CREATE TABLE [dbo].[systargetservers] (
    [server_id] int NOT NULL IDENTITY(1,1)
    ,[server_name] sysname NOT NULL
    ,[location] nvarchar(200) NULL
    ,[time_zone_adjustment] int NOT NULL
    ,[enlist_date] datetime NOT NULL
    ,[last_poll_date] datetime NOT NULL
    ,[status] int NOT NULL
    ,[local_time_at_last_poll] datetime NOT NULL
    ,[enlisted_by_nt_user] nvarchar(100) NOT NULL
    ,[poll_interval] int NOT NULL
)
GO

GRANT SELECT, UPDATE ON [systargetservers] TO [TargetServersRole]
GO
