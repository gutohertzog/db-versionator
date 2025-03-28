USE [msdb]
GO

CREATE ROLE [UtilityIMRReader]
GO

ALTER ROLE [UtilityIMRReader] ADD MEMBER [UtilityIMRWriter] -- DATABASE_ROLE
GO
