USE [msdb]
GO

CREATE ROLE [SQLAgentOperatorRole]
GO

ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [PolicyAdministratorRole] -- DATABASE_ROLE
GO
