USE [msdb]
GO

CREATE TABLE [dbo].[sysdownloadlist] (
    [instance_id] int NOT NULL IDENTITY(1,1)
    ,[source_server] sysname NOT NULL
    ,[operation_code] tinyint NOT NULL
    ,[object_type] tinyint NOT NULL
    ,[object_id] uniqueidentifier NOT NULL
    ,[target_server] sysname NOT NULL
    ,[error_message] nvarchar(1024) NULL
    ,[date_posted] datetime NOT NULL
    ,[date_downloaded] datetime NULL
    ,[status] tinyint NOT NULL
    ,[deleted_object_name] sysname NULL
)
GO

GRANT DELETE, SELECT, UPDATE ON [sysdownloadlist] TO [TargetServersRole]
GO
