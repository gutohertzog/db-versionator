USE [msdb]
GO

CREATE ROLE [SQLAgentUserRole]
GO

ALTER ROLE [SQLAgentUserRole] ADD MEMBER [dc_operator] -- DATABASE_ROLE
ALTER ROLE [SQLAgentUserRole] ADD MEMBER [MS_DataCollectorInternalUser] -- SQL_USER
ALTER ROLE [SQLAgentUserRole] ADD MEMBER [SQLAgentReaderRole] -- DATABASE_ROLE
GO
