USE [msdb]
GO

CREATE TABLE [dbo].[restorehistory] (
    [restore_history_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[restore_date] datetime NULL
    ,[destination_database_name] nvarchar(128) NULL
    ,[user_name] nvarchar(128) NULL
    ,[backup_set_id] int NOT NULL -- FK [backupset]
    ,[restore_type] char(1) NULL
    ,[replace] bit NULL
    ,[recovery] bit NULL
    ,[restart] bit NULL
    ,[stop_at] datetime NULL
    ,[device_count] tinyint NULL
    ,[stop_at_mark_name] nvarchar(128) NULL
    ,[stop_before] bit NULL

    ,CONSTRAINT [PK__restoreh__FDC4B031DA23FF71]
        PRIMARY KEY ([restore_history_id])

    ,CONSTRAINT [FK__restorehi__backu__6F4A8121]
        FOREIGN KEY ([backup_set_id])
        REFERENCES [dbo].[backupset] ([backup_set_id])
)
GO

GRANT SELECT ON [restorehistory] TO [public]
GO
