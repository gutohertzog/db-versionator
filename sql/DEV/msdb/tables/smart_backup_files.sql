USE [msdb]
GO

CREATE TABLE [dbo].[smart_backup_files] (
    [backup_path] nvarchar(260) NOT NULL -- PK
    ,[last_modified_utc] datetime NULL
    ,[backup_type] smallint NULL
    ,[expiration_date] datetime NULL
    ,[user_name] nvarchar(128) NULL
    ,[server_name] nvarchar(128) NULL
    ,[database_name] nvarchar(128) NULL
    ,[backup_size] numeric(20, 0) NULL
    ,[first_lsn] numeric(25, 0) NULL
    ,[last_lsn] numeric(25, 0) NULL
    ,[database_backup_lsn] numeric(25, 0) NULL
    ,[backup_start_date] datetime NULL
    ,[backup_finish_date] datetime NULL
    ,[machine_name] nvarchar(128) NULL
    ,[last_recovery_fork_id] uniqueidentifier NULL
    ,[first_recovery_fork_id] uniqueidentifier NULL
    ,[fork_point_lsn] numeric(25, 0) NULL
    ,[availability_group_guid] uniqueidentifier NULL
    ,[database_guid] uniqueidentifier NULL
    ,[status] char(1) NULL

    ,CONSTRAINT [PK__smart_ba__AFE4014F5184EB8B]
        PRIMARY KEY ([backup_path])
)
GO
