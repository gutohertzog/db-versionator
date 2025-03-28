USE [msdb]
GO

CREATE VIEW dbo.sysdatatypemappings AS SELECT * FROM sys.fn_helpdatatypemap('%', '%', '%', '%', '%', '%', 0)
GO
