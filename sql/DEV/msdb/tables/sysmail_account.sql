USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_account] (
    [account_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[name] sysname NOT NULL -- UK
    ,[description] nvarchar(256) NULL
    ,[email_address] nvarchar(128) NOT NULL
    ,[display_name] nvarchar(128) NULL
    ,[replyto_address] nvarchar(128) NULL
    ,[last_mod_datetime] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [SYSMAIL_ACCOUNT_IDMustBeUnique]
        PRIMARY KEY ([account_id])

    ,CONSTRAINT [SYSMAIL_ACCOUNT_NameMustBeUnique]
        UNIQUE CLUSTERED ([name], [name])
)
GO

ALTER TABLE [dbo].[sysmail_account] ADD CONSTRAINT [DF__sysmail_a__last___318258D2]
    DEFAULT ((getdate())) FOR [last_mod_datetime]
GO

ALTER TABLE [dbo].[sysmail_account] ADD CONSTRAINT [DF__sysmail_a__last___32767D0B]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO
