USE [msdb]
GO

CREATE TABLE [dbo].[backupfilegroup] (
    [backup_set_id] int NOT NULL -- PK FK [backupset]
    ,[name] nvarchar(128) NOT NULL
    ,[filegroup_id] int NOT NULL -- PK
    ,[filegroup_guid] uniqueidentifier NULL
    ,[type] char(2) NOT NULL
    ,[type_desc] nvarchar(60) NOT NULL
    ,[is_default] bit NOT NULL
    ,[is_readonly] bit NOT NULL
    ,[log_filegroup_guid] uniqueidentifier NULL

    ,CONSTRAINT [PK__backupfi__760CD67A8A3A643C]
        PRIMARY KEY ([backup_set_id], [filegroup_id])

    ,CONSTRAINT [FK__backupfil__backu__6991A7CB]
        FOREIGN KEY ([backup_set_id])
        REFERENCES [dbo].[backupset] ([backup_set_id])
)
GO
