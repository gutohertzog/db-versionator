USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_send_retries] (
    [conversation_handle] uniqueidentifier NOT NULL -- PK
    ,[mailitem_id] int NOT NULL -- FK [sysmail_mailitems]
    ,[send_attempts] int NOT NULL -- DF [1]
    ,[last_send_attempt_date] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK__sysmail___C010B7E1BE549356]
        PRIMARY KEY ([conversation_handle])

    ,CONSTRAINT [FK_mailitems_mailitem_id]
        FOREIGN KEY ([mailitem_id])
        REFERENCES [dbo].[sysmail_mailitems] ([mailitem_id])
)
GO

ALTER TABLE [dbo].[sysmail_send_retries] ADD CONSTRAINT [DF__sysmail_s__last___640DD89F]
    DEFAULT ((getdate())) FOR [last_send_attempt_date]
GO

ALTER TABLE [dbo].[sysmail_send_retries] ADD CONSTRAINT [DF__sysmail_s__send___6319B466]
    DEFAULT (((1))) FOR [send_attempts]
GO
