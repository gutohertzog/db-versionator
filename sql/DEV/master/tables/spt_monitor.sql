USE [master]
GO

CREATE TABLE [dbo].[spt_monitor] (
    [lastrun] datetime NOT NULL
    ,[cpu_busy] int NOT NULL
    ,[io_busy] int NOT NULL
    ,[idle] int NOT NULL
    ,[pack_received] int NOT NULL
    ,[pack_sent] int NOT NULL
    ,[connections] int NOT NULL
    ,[pack_errors] int NOT NULL
    ,[total_read] int NOT NULL
    ,[total_write] int NOT NULL
    ,[total_errors] int NOT NULL
)
GO

GRANT SELECT ON [spt_monitor] TO [public]
GO
