USE [msdb]
GO

CREATE TABLE [dbo].[backupmediafamily] (
    [media_set_id] int NOT NULL -- PK FK [backupmediaset]
    ,[family_sequence_number] tinyint NOT NULL -- PK
    ,[media_family_id] uniqueidentifier NULL
    ,[media_count] int NULL
    ,[logical_device_name] nvarchar(128) NULL
    ,[physical_device_name] nvarchar(260) NULL
    ,[device_type] tinyint NULL
    ,[physical_block_size] int NULL
    ,[mirror] tinyint NOT NULL -- PK DF [0]

    ,CONSTRAINT [PK__backupme__0C13C86F3DDD98AF]
        PRIMARY KEY ([media_set_id], [family_sequence_number], [mirror])

    ,CONSTRAINT [FK__backupmed__media__62E4AA3C]
        FOREIGN KEY ([media_set_id])
        REFERENCES [dbo].[backupmediaset] ([media_set_id])
)
GO

ALTER TABLE [dbo].[backupmediafamily] ADD CONSTRAINT [DF__backupmed__mirro__63D8CE75]
    DEFAULT (((0))) FOR [mirror]
GO

GRANT SELECT ON [backupmediafamily] TO [public]
GO
