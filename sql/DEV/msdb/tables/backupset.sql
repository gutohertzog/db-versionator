USE [msdb]
GO

CREATE TABLE [dbo].[backupset] (
    [backup_set_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[backup_set_uuid] uniqueidentifier NOT NULL
    ,[media_set_id] int NOT NULL -- FK [backupmediaset]
    ,[first_family_number] tinyint NULL
    ,[first_media_number] smallint NULL
    ,[last_family_number] tinyint NULL
    ,[last_media_number] smallint NULL
    ,[catalog_family_number] tinyint NULL
    ,[catalog_media_number] smallint NULL
    ,[position] int NULL
    ,[expiration_date] datetime NULL
    ,[software_vendor_id] int NULL
    ,[name] nvarchar(128) NULL
    ,[description] nvarchar(255) NULL
    ,[user_name] nvarchar(128) NULL
    ,[software_major_version] tinyint NULL
    ,[software_minor_version] tinyint NULL
    ,[software_build_version] smallint NULL
    ,[time_zone] smallint NULL
    ,[mtf_minor_version] tinyint NULL
    ,[first_lsn] numeric(25, 0) NULL
    ,[last_lsn] numeric(25, 0) NULL
    ,[checkpoint_lsn] numeric(25, 0) NULL
    ,[database_backup_lsn] numeric(25, 0) NULL
    ,[database_creation_date] datetime NULL
    ,[backup_start_date] datetime NULL
    ,[backup_finish_date] datetime NULL
    ,[type] char(1) NULL
    ,[sort_order] smallint NULL
    ,[code_page] smallint NULL
    ,[compatibility_level] tinyint NULL
    ,[database_version] int NULL
    ,[backup_size] numeric(20, 0) NULL
    ,[database_name] nvarchar(128) NULL
    ,[server_name] nvarchar(128) NULL
    ,[machine_name] nvarchar(128) NULL
    ,[flags] int NULL
    ,[unicode_locale] int NULL
    ,[unicode_compare_style] int NULL
    ,[collation_name] nvarchar(128) NULL
    ,[is_password_protected] bit NULL
    ,[recovery_model] nvarchar(60) NULL
    ,[has_bulk_logged_data] bit NULL
    ,[is_snapshot] bit NULL
    ,[is_readonly] bit NULL
    ,[is_single_user] bit NULL
    ,[has_backup_checksums] bit NULL
    ,[is_damaged] bit NULL
    ,[begins_log_chain] bit NULL
    ,[has_incomplete_metadata] bit NULL
    ,[is_force_offline] bit NULL
    ,[is_copy_only] bit NULL
    ,[first_recovery_fork_guid] uniqueidentifier NULL
    ,[last_recovery_fork_guid] uniqueidentifier NULL
    ,[fork_point_lsn] numeric(25, 0) NULL
    ,[database_guid] uniqueidentifier NULL
    ,[family_guid] uniqueidentifier NULL
    ,[differential_base_lsn] numeric(25, 0) NULL
    ,[differential_base_guid] uniqueidentifier NULL
    ,[compressed_backup_size] numeric(20, 0) NULL
    ,[key_algorithm] nvarchar(32) NULL
    ,[encryptor_thumbprint] varbinary(20) NULL
    ,[encryptor_type] nvarchar(32) NULL
    ,[last_valid_restore_time] datetime NULL
    ,[compression_algorithm] nvarchar(32) NULL

    ,CONSTRAINT [PK__backupse__21F79AABE96B7933]
        PRIMARY KEY ([backup_set_id])

    ,CONSTRAINT [FK__backupset__media__66B53B20]
        FOREIGN KEY ([media_set_id])
        REFERENCES [dbo].[backupmediaset] ([media_set_id])
)
GO

GRANT SELECT ON [backupset] TO [public]
GO
