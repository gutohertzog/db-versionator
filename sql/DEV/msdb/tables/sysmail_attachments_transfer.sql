USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_attachments_transfer] (
    [transfer_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[uid] uniqueidentifier NOT NULL
    ,[filename] nvarchar(260) NOT NULL
    ,[filesize] int NOT NULL
    ,[attachment] varbinary(MAX) NULL
    ,[create_date] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK__sysmail___78E6FD339D847D7A]
        PRIMARY KEY ([transfer_id])
)
GO

ALTER TABLE [dbo].[sysmail_attachments_transfer] ADD CONSTRAINT [DF__sysmail_a__creat__7073AF84]
    DEFAULT ((getdate())) FOR [create_date]
GO
