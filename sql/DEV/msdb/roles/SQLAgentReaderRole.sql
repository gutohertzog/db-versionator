USE [msdb]
GO

CREATE ROLE [SQLAgentReaderRole]
GO

ALTER ROLE [SQLAgentReaderRole] ADD MEMBER [SQLAgentOperatorRole] -- DATABASE_ROLE
GO
