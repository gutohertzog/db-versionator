USE [msdb]
GO

CREATE ROLE [dc_operator]
GO

ALTER ROLE [dc_operator] ADD MEMBER [dc_admin] -- DATABASE_ROLE
GO
