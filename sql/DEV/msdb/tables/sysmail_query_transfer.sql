USE [msdb]
GO

CREATE TABLE [dbo].[sysmail_query_transfer] (
    [uid] uniqueidentifier NOT NULL -- PK
    ,[text_data] nvarchar(MAX) NULL
    ,[create_date] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK__sysmail___DD701264F9D22E6B]
        PRIMARY KEY ([uid])
)
GO

ALTER TABLE [dbo].[sysmail_query_transfer] ADD CONSTRAINT [DF__sysmail_q__creat__6D9742D9]
    DEFAULT ((getdate())) FOR [create_date]
GO
