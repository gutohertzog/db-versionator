USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_mailitems] (
    [mailitem_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[profile_id] int NOT NULL
    ,[recipients] varchar(MAX) NULL
    ,[copy_recipients] varchar(MAX) NULL
    ,[blind_copy_recipients] varchar(MAX) NULL
    ,[subject] nvarchar(255) NULL
    ,[from_address] varchar(MAX) NULL
    ,[reply_to] varchar(MAX) NULL
    ,[body] nvarchar(MAX) NULL
    ,[body_format] varchar(20) NULL
    ,[importance] varchar(6) NULL -- CK ['HIGH' OR 'NORMAL' OR 'LOW']
    ,[sensitivity] varchar(12) NULL -- CK ['CONFIDENTIAL' OR 'PRIVATE' OR 'PERSONAL' OR 'NORMAL']
    ,[file_attachments] nvarchar(MAX) NULL
    ,[attachment_encoding] varchar(20) NULL -- CK ['UUENCODE' OR 'BINHEX' OR 'S/MIME' OR 'MIME']
    ,[query] nvarchar(MAX) NULL
    ,[execute_query_database] sysname NULL
    ,[attach_query_result_as_file] bit NULL
    ,[query_result_header] bit NULL
    ,[query_result_width] int NULL
    ,[query_result_separator] char(1) NULL
    ,[exclude_query_output] bit NULL
    ,[append_query_error] bit NULL
    ,[send_request_date] datetime NOT NULL -- DF [getdate()]
    ,[send_request_user] sysname NOT NULL -- DF [suser_sname()]
    ,[sent_account_id] int NULL
    ,[sent_status] tinyint NULL -- DF [0]
    ,[sent_date] datetime NULL
    ,[last_mod_date] datetime NOT NULL -- DF [getdate()]
    ,[last_mod_user] sysname NOT NULL -- DF [suser_sname()]

    ,CONSTRAINT [sysmail_mailitems_id_MustBeUnique]
        PRIMARY KEY ([mailitem_id])

    ,CONSTRAINT [sysmail_OutMailAttachmentEncodingMustBeValid]
        CHECK (([attachment_encoding]='UUENCODE' OR [attachment_encoding]='BINHEX' OR [attachment_encoding]='S/MIME' OR [attachment_encoding]='MIME'))

    ,CONSTRAINT [sysmail_OutMailImportanceMustBeValid]
        CHECK (([importance]='HIGH' OR [importance]='NORMAL' OR [importance]='LOW'))

    ,CONSTRAINT [sysmail_OutMailSensitivityMustBeValid]
        CHECK (([sensitivity]='CONFIDENTIAL' OR [sensitivity]='PRIVATE' OR [sensitivity]='PERSONAL' OR [sensitivity]='NORMAL'))
)
GO

ALTER TABLE [dbo].[sysmail_mailitems] ADD CONSTRAINT [DF__sysmail_m__last___5006DFF2]
    DEFAULT ((getdate())) FOR [last_mod_date]
GO

ALTER TABLE [dbo].[sysmail_mailitems] ADD CONSTRAINT [DF__sysmail_m__last___50FB042B]
    DEFAULT ((suser_sname())) FOR [last_mod_user]
GO

ALTER TABLE [dbo].[sysmail_mailitems] ADD CONSTRAINT [DF__sysmail_m__send___4D2A7347]
    DEFAULT ((getdate())) FOR [send_request_date]
GO

ALTER TABLE [dbo].[sysmail_mailitems] ADD CONSTRAINT [DF__sysmail_m__send___4E1E9780]
    DEFAULT ((suser_sname())) FOR [send_request_user]
GO

ALTER TABLE [dbo].[sysmail_mailitems] ADD CONSTRAINT [DF__sysmail_m__sent___4F12BBB9]
    DEFAULT (((0))) FOR [sent_status]
GO
