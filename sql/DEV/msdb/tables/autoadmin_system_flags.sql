USE [msdb]
GO

CREATE TABLE [dbo].[autoadmin_system_flags] (
    [name] nvarchar(128) NOT NULL
    ,[value] nvarchar(MAX) NOT NULL
)
GO
