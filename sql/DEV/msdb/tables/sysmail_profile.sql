USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_profile] (
    [profile_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[name] sysname NOT NULL -- UK
    ,[description] nvarchar(256) NULL
    ,[last_mod_datetime] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [SYSMAIL_PROFILE_IDMustBeUnique]
        PRIMARY KEY ([profile_id])

    ,CONSTRAINT [SYSMAIL_PROFILE_NameMustBeUnique]
        UNIQUE CLUSTERED ([name], [name])
)
GO

ALTER TABLE [dbo].[sysmail_profile] ADD CONSTRAINT [DF__sysmail_p__last___2704CA5F]
    DEFAULT ((getdate())) FOR [last_mod_datetime]
GO

ALTER TABLE [dbo].[sysmail_profile] ADD CONSTRAINT [DF__sysmail_p__last___27F8EE98]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO
