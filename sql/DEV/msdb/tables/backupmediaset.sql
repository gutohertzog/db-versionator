USE [msdb]
GO

CREATE TABLE [dbo].[backupmediaset] (
    [media_set_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[media_uuid] uniqueidentifier NULL
    ,[media_family_count] tinyint NULL
    ,[name] nvarchar(128) NULL
    ,[description] nvarchar(255) NULL
    ,[software_name] nvarchar(128) NULL
    ,[software_vendor_id] int NULL
    ,[MTF_major_version] tinyint NULL
    ,[mirror_count] tinyint NULL
    ,[is_password_protected] bit NULL
    ,[is_compressed] bit NULL
    ,[is_encrypted] bit NULL

    ,CONSTRAINT [PK__backupme__DAC69E4D7C499809]
        PRIMARY KEY ([media_set_id])
)
GO

GRANT SELECT ON [backupmediaset] TO [public]
GO
