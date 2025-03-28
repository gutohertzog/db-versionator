USE [msdb]
GO

CREATE TABLE [dbo].[logmarkhistory] (
    [database_name] nvarchar(128) NOT NULL
    ,[mark_name] nvarchar(128) NOT NULL
    ,[description] nvarchar(255) NULL
    ,[user_name] nvarchar(128) NOT NULL
    ,[lsn] numeric(25, 0) NOT NULL
    ,[mark_time] datetime NOT NULL
)
GO

GRANT SELECT ON [logmarkhistory] TO [public]
GO
