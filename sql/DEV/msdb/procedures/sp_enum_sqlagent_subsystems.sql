USE [msdb]
GO

CREATE   PROCEDURE sp_enum_sqlagent_subsystems
AS
BEGIN
  DECLARE @retval         INT
  EXEC @retval = msdb.dbo.sp_enum_sqlagent_subsystems_internal
  RETURN(@retval)
END
GO

GRANT EXECUTE ON [sp_enum_sqlagent_subsystems] TO [SQLAgentUserRole]
GO
