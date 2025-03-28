USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_configuration] (
    [paramname] nvarchar(256) NOT NULL -- PK
    ,[paramvalue] nvarchar(256) NULL
    ,[description] nvarchar(256) NULL
    ,[last_mod_datetime] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [SYSMAIL_CONFIGURATION_ParamnameMustBeUnique]
        PRIMARY KEY ([paramname])
)
GO

ALTER TABLE [dbo].[sysmail_configuration] ADD CONSTRAINT [DF__sysmail_c__last___4959E263]
    DEFAULT ((getdate())) FOR [last_mod_datetime]
GO

ALTER TABLE [dbo].[sysmail_configuration] ADD CONSTRAINT [DF__sysmail_c__last___4A4E069C]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO
