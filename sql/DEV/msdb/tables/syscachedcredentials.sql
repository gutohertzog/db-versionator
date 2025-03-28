USE [msdb]
GO

CREATE TABLE [dbo].[syscachedcredentials] (
    [login_name] sysname NOT NULL -- PK
    ,[has_server_access] bit NOT NULL -- DF [0]
    ,[is_sysadmin_member] bit NOT NULL -- DF [0]
    ,[cachedate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK__syscache__F6D56B56F4E81581]
        PRIMARY KEY ([login_name])
)
GO

ALTER TABLE [dbo].[syscachedcredentials] ADD CONSTRAINT [DF__syscached__cache__05D8E0BE]
    DEFAULT ((getdate())) FOR [cachedate]
GO

ALTER TABLE [dbo].[syscachedcredentials] ADD CONSTRAINT [DF__syscached__has_s__03F0984C]
    DEFAULT (((0))) FOR [has_server_access]
GO

ALTER TABLE [dbo].[syscachedcredentials] ADD CONSTRAINT [DF__syscached__is_sy__04E4BC85]
    DEFAULT (((0))) FOR [is_sysadmin_member]
GO
