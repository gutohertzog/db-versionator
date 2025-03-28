USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_attachments] (
    [attachment_id] int NOT NULL IDENTITY(1,1)
    ,[mailitem_id] int NOT NULL -- FK [sysmail_mailitems]
    ,[filename] nvarchar(260) NOT NULL
    ,[filesize] int NOT NULL
    ,[attachment] varbinary(MAX) NULL
    ,[last_mod_date] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [FK_sysmail_mailitems_mailitem_id]
        FOREIGN KEY ([mailitem_id])
        REFERENCES [dbo].[sysmail_mailitems] ([mailitem_id])
)
GO

ALTER TABLE [dbo].[sysmail_attachments] ADD CONSTRAINT [DF__sysmail_a__last___5D60DB10]
    DEFAULT ((getdate())) FOR [last_mod_date]
GO

ALTER TABLE [dbo].[sysmail_attachments] ADD CONSTRAINT [DF__sysmail_a__last___5E54FF49]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO
