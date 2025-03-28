USE [msdb]
GO

CREATE ROLE [ServerGroupReaderRole]
GO

ALTER ROLE [ServerGroupReaderRole] ADD MEMBER [ServerGroupAdministratorRole] -- DATABASE_ROLE
GO
