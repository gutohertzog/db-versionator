USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_log] (
    [log_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[event_type] int NOT NULL
    ,[log_date] datetime NOT NULL -- DF [getdate()]
    ,[description] nvarchar(MAX) NULL
    ,[process_id] int NULL
    ,[mailitem_id] int NULL
    ,[account_id] int NULL
    ,[last_mod_date] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [sysmail_log_id_MustBeUnique]
        PRIMARY KEY ([log_id])
)
GO

ALTER TABLE [dbo].[sysmail_log] ADD CONSTRAINT [DF__sysmail_l__last___67DE6983]
    DEFAULT ((getdate())) FOR [last_mod_date]
GO

ALTER TABLE [dbo].[sysmail_log] ADD CONSTRAINT [DF__sysmail_l__last___68D28DBC]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO

ALTER TABLE [dbo].[sysmail_log] ADD CONSTRAINT [DF__sysmail_l__log_d__66EA454A]
    DEFAULT ((getdate())) FOR [log_date]
GO
