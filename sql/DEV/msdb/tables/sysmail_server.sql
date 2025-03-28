USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_server] (
    [account_id] int NOT NULL -- PK FK [sysmail_account]
    ,[servertype] sysname NOT NULL -- PK FK [sysmail_servertype]
    ,[servername] sysname NOT NULL
    ,[port] int NOT NULL -- DF [25]
    ,[username] nvarchar(128) NULL
    ,[credential_id] int NULL
    ,[use_default_credentials] bit NOT NULL -- DF [0]
    ,[enable_ssl] bit NOT NULL -- DF [0]
    ,[flags] int NOT NULL -- DF [0]
    ,[timeout] int NULL
    ,[last_mod_datetime] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [SYSMAIL_ACCOUNT_AccountServerTypeMustBeUnique]
        PRIMARY KEY ([account_id], [servertype])

    ,CONSTRAINT [FK__sysmail_s__accou__3FD07829]
        FOREIGN KEY ([account_id])
        REFERENCES [dbo].[sysmail_account] ([account_id])

    ,CONSTRAINT [FK__sysmail_s__serve__40C49C62]
        FOREIGN KEY ([servertype])
        REFERENCES [dbo].[sysmail_servertype] ([servertype])
)
GO

ALTER TABLE [dbo].[sysmail_server] ADD CONSTRAINT [DF__sysmail_s__enabl__43A1090D]
    DEFAULT (((0))) FOR [enable_ssl]
GO

ALTER TABLE [dbo].[sysmail_server] ADD CONSTRAINT [DF__sysmail_s__flags__44952D46]
    DEFAULT (((0))) FOR [flags]
GO

ALTER TABLE [dbo].[sysmail_server] ADD CONSTRAINT [DF__sysmail_s__last___4589517F]
    DEFAULT ((getdate())) FOR [last_mod_datetime]
GO

ALTER TABLE [dbo].[sysmail_server] ADD CONSTRAINT [DF__sysmail_s__last___467D75B8]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO

ALTER TABLE [dbo].[sysmail_server] ADD CONSTRAINT [DF__sysmail_s__use_d__42ACE4D4]
    DEFAULT (((0))) FOR [use_default_credentials]
GO

ALTER TABLE [dbo].[sysmail_server] ADD CONSTRAINT [DF__sysmail_se__port__41B8C09B]
    DEFAULT (((25))) FOR [port]
GO
