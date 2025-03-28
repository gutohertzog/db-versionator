USE [msdb]
GO

CREATE   PROCEDURE [dbo].[sp_ssis_checkexists]
  @name sysname,
  @folderid uniqueidentifier
AS
  SET NOCOUNT ON
  SELECT TOP 1 1 FROM sysssispackages WHERE [name] = @name AND [folderid] = @folderid
  RETURN 0    -- SUCCESS
GO

GRANT EXECUTE ON [sp_ssis_checkexists] TO [db_ssisadmin]
GRANT EXECUTE ON [sp_ssis_checkexists] TO [db_ssisltduser]
GRANT EXECUTE ON [sp_ssis_checkexists] TO [db_ssisoperator]
GO
