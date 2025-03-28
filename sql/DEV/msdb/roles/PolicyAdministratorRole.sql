USE [msdb]
GO

CREATE ROLE [PolicyAdministratorRole]
GO

ALTER ROLE [PolicyAdministratorRole] ADD MEMBER [##MS_PolicyEventProcessingLogin##] -- SQL_USER
ALTER ROLE [PolicyAdministratorRole] ADD MEMBER [##MS_PolicyTsqlExecutionLogin##] -- SQL_USER
GO
