USE [msdb]
GO

CREATE ROLE [db_ssisoperator]
GO

ALTER ROLE [db_ssisoperator] ADD MEMBER [dc_operator] -- DATABASE_ROLE
ALTER ROLE [db_ssisoperator] ADD MEMBER [dc_proxy] -- DATABASE_ROLE
ALTER ROLE [db_ssisoperator] ADD MEMBER [MS_DataCollectorInternalUser] -- SQL_USER
GO
