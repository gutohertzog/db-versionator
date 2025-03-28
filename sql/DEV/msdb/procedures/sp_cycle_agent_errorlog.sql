USE [msdb]
GO

CREATE   PROCEDURE sp_cycle_agent_errorlog
AS
BEGIN
   exec sp_sqlagent_notify N'L'
END
GO
