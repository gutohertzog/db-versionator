USE [msdb]
GO

CREATE   PROCEDURE dbo.sp_agent_get_jobstep
  @job_id                UNIQUEIDENTIFIER,
  @is_system             TINYINT = 0
AS
BEGIN
    -- user jobs
    IF(@is_system = 1)
     BEGIN
        EXEC sys.sp_sqlagent_help_jobstep  @job_id = @job_id
    END
    ELSE
    BEGIN
        EXECUTE msdb.dbo.sp_help_jobstep @job_id = @job_id
    END
END
GO

GRANT EXECUTE ON [sp_agent_get_jobstep] TO [SQLAgentUserRole]
GRANT EXECUTE ON [sp_agent_get_jobstep] TO [TargetServersRole]
GO
