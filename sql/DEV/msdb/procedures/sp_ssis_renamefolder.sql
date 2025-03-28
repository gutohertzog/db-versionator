USE [msdb]
GO

CREATE   PROCEDURE [dbo].[sp_ssis_renamefolder]
  @folderid uniqueidentifier,
  @name sysname
AS
   --Check security
   IF (IS_MEMBER('db_ssisltduser')<>1) AND (IS_MEMBER('db_ssisadmin')<>1) AND (IS_SRVROLEMEMBER('sysadmin')<>1)
   BEGIN
       RAISERROR (14591, -1, -1, @name)
       RETURN 1  -- Failure
   END

   --// Security check passed, INSERT now
   UPDATE sysssispackagefolders
   SET [foldername] = @name
   WHERE [folderid] = @folderid
GO

GRANT EXECUTE ON [sp_ssis_renamefolder] TO [db_ssisadmin]
GRANT EXECUTE ON [sp_ssis_renamefolder] TO [db_ssisltduser]
GO
