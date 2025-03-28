USE [msdb]
GO

CREATE ROLE [db_ssisltduser]
GO

ALTER ROLE [db_ssisltduser] ADD MEMBER [dc_operator] -- DATABASE_ROLE
ALTER ROLE [db_ssisltduser] ADD MEMBER [dc_proxy] -- DATABASE_ROLE
GO
