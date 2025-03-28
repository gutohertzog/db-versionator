USE [msdb]
GO

CREATE TABLE [dbo].[sqlagent_info] (
    [attribute] sysname NOT NULL
    ,[value] nvarchar(512) NOT NULL
)
GO
