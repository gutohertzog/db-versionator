USE [msdb]
GO

CREATE TABLE [dbo].[backupfile] (
    [backup_set_id] int NOT NULL -- PK FK [backupset]
    ,[first_family_number] tinyint NULL
    ,[first_media_number] smallint NULL
    ,[filegroup_name] nvarchar(128) NULL
    ,[page_size] int NULL
    ,[file_number] numeric(10, 0) NOT NULL -- PK
    ,[backed_up_page_count] numeric(10, 0) NULL
    ,[file_type] char(1) NULL
    ,[source_file_block_size] numeric(10, 0) NULL
    ,[file_size] numeric(20, 0) NULL
    ,[logical_name] nvarchar(128) NULL
    ,[physical_drive] nvarchar(260) NULL
    ,[physical_name] nvarchar(260) NULL
    ,[state] tinyint NULL
    ,[state_desc] nvarchar(64) NULL
    ,[create_lsn] numeric(25, 0) NULL
    ,[drop_lsn] numeric(25, 0) NULL
    ,[file_guid] uniqueidentifier NULL
    ,[read_only_lsn] numeric(25, 0) NULL
    ,[read_write_lsn] numeric(25, 0) NULL
    ,[differential_base_lsn] numeric(25, 0) NULL
    ,[differential_base_guid] uniqueidentifier NULL
    ,[backup_size] numeric(20, 0) NULL
    ,[filegroup_guid] uniqueidentifier NULL
    ,[is_readonly] bit NULL
    ,[is_present] bit NULL

    ,CONSTRAINT [PK__backupfi__57D1800AFA37E874]
        PRIMARY KEY ([backup_set_id], [file_number])

    ,CONSTRAINT [FK__backupfil__backu__6C6E1476]
        FOREIGN KEY ([backup_set_id])
        REFERENCES [dbo].[backupset] ([backup_set_id])
)
GO

GRANT SELECT ON [backupfile] TO [public]
GO
