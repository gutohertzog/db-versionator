USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_principalprofile] (
    [profile_id] int NOT NULL -- PK FK [sysmail_profile]
    ,[principal_sid] varbinary(85) NOT NULL -- PK
    ,[is_default] bit NOT NULL -- DF [0]
    ,[last_mod_datetime] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [SYSMAIL_PRINCIPALPROFILE_ProfilePrincipalMustBeUnique]
        PRIMARY KEY ([profile_id], [principal_sid])

    ,CONSTRAINT [FK__sysmail_p__profi__2AD55B43]
        FOREIGN KEY ([profile_id])
        REFERENCES [dbo].[sysmail_profile] ([profile_id])
)
GO

ALTER TABLE [dbo].[sysmail_principalprofile] ADD CONSTRAINT [DF__sysmail_p__is_de__2BC97F7C]
    DEFAULT (((0))) FOR [is_default]
GO

ALTER TABLE [dbo].[sysmail_principalprofile] ADD CONSTRAINT [DF__sysmail_p__last___2CBDA3B5]
    DEFAULT ((getdate())) FOR [last_mod_datetime]
GO

ALTER TABLE [dbo].[sysmail_principalprofile] ADD CONSTRAINT [DF__sysmail_p__last___2DB1C7EE]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO
