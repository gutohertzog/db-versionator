USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_servertype] (
    [servertype] sysname NOT NULL -- PK
    ,[is_incoming] bit NOT NULL -- DF [0]
    ,[is_outgoing] bit NOT NULL -- DF [1]
    ,[last_mod_datetime] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [SYSMAIL_SERVERTYPE_TypeMustBeUnique]
        PRIMARY KEY ([servertype])
)
GO

ALTER TABLE [dbo].[sysmail_servertype] ADD CONSTRAINT [DF__sysmail_s__is_in__3A179ED3]
    DEFAULT (((0))) FOR [is_incoming]
GO

ALTER TABLE [dbo].[sysmail_servertype] ADD CONSTRAINT [DF__sysmail_s__is_ou__3B0BC30C]
    DEFAULT (((1))) FOR [is_outgoing]
GO

ALTER TABLE [dbo].[sysmail_servertype] ADD CONSTRAINT [DF__sysmail_s__last___3BFFE745]
    DEFAULT ((getdate())) FOR [last_mod_datetime]
GO

ALTER TABLE [dbo].[sysmail_servertype] ADD CONSTRAINT [DF__sysmail_s__last___3CF40B7E]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO
