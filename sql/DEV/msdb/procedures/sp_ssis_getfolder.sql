USE [msdb]
GO

CREATE   PROCEDURE [dbo].[sp_ssis_getfolder]
  @name sysname,
  @parentfolderid uniqueidentifier
AS
  SELECT
   folder.folderid,
   folder.foldername,
   folder.parentfolderid,
   parent.foldername
  FROM
      sysssispackagefolders folder
  LEFT OUTER JOIN
      sysssispackagefolders parent
  ON
      folder.parentfolderid = parent.folderid
  WHERE
      folder.foldername = @name AND
      (folder.parentfolderid = @parentfolderid OR
      (@parentfolderid IS NULL AND folder.parentfolderid IS NULL))
GO

GRANT EXECUTE ON [sp_ssis_getfolder] TO [db_ssisadmin]
GRANT EXECUTE ON [sp_ssis_getfolder] TO [db_ssisltduser]
GRANT EXECUTE ON [sp_ssis_getfolder] TO [db_ssisoperator]
GO
