USE [msdb]
GO

CREATE ROLE [dc_admin]
GO

ALTER ROLE [dc_admin] ADD MEMBER [MS_DataCollectorInternalUser] -- SQL_USER
GO
