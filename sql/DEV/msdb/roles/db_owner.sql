USE [msdb]
GO

CREATE ROLE [db_owner]
GO

ALTER ROLE [db_owner] ADD MEMBER [dbo] -- SQL_USER
GO
