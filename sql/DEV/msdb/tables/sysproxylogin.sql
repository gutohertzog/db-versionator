USE [msdb]
GO

CREATE TABLE [dbo].[sysproxylogin] (
    [proxy_id] int NOT NULL
    ,[sid] varbinary(85) NULL
    ,[flags] int NOT NULL -- DF [0]
)
GO

ALTER TABLE [dbo].[sysproxylogin] ADD CONSTRAINT [DF__sysproxyl__flags__5165187F]
    DEFAULT (((0))) FOR [flags]
GO
