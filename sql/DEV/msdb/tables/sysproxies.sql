USE [msdb]
GO

CREATE TABLE [dbo].[sysproxies] (
    [proxy_id] int NOT NULL IDENTITY(1,1)
    ,[name] sysname NOT NULL
    ,[credential_id] int NOT NULL
    ,[enabled] tinyint NOT NULL
    ,[description] nvarchar(512) NULL
    ,[user_sid] varbinary(85) NOT NULL
    ,[credential_date_created] datetime NOT NULL
)
GO

GRANT SELECT ON [sysproxies] TO [TargetServersRole]
GO
