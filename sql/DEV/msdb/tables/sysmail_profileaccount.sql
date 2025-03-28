USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_profileaccount] (
    [profile_id] int NOT NULL -- PK
    ,[account_id] int NOT NULL -- PK FK [sysmail_account]
    ,[sequence_number] int NULL
    ,[last_mod_datetime] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [SYSMAIL_ACCOUNT_ProfileAccountMustBeUnique]
        PRIMARY KEY ([profile_id], [account_id])

    ,CONSTRAINT [FK__sysmail_p__accou__3552E9B6]
        FOREIGN KEY ([account_id])
        REFERENCES [dbo].[sysmail_account] ([account_id])
)
GO

ALTER TABLE [dbo].[sysmail_profileaccount] ADD CONSTRAINT [DF__sysmail_p__last___36470DEF]
    DEFAULT ((getdate())) FOR [last_mod_datetime]
GO

ALTER TABLE [dbo].[sysmail_profileaccount] ADD CONSTRAINT [DF__sysmail_p__last___373B3228]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO
