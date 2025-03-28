USE [AdventureWorks2022]
GO

CREATE ROLE [db_owner]
GO

ALTER ROLE [db_owner] ADD MEMBER [dbo] -- SQL_USER
GO
