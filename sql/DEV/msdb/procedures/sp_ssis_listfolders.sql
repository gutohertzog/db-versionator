USE [msdb]
GO

CREATE   PROCEDURE [dbo].[sp_ssis_listfolders]
  @parentfolderid uniqueidentifier = NULL
AS
  SELECT
   folderid,
   parentfolderid,
   foldername
  FROM
      sysssispackagefolders
  WHERE
      [parentfolderid] = @parentfolderid OR
      (@parentfolderid IS NULL AND [parentfolderid] IS NULL)
  ORDER BY
      foldername
GO

GRANT EXECUTE ON [sp_ssis_listfolders] TO [db_ssisadmin]
GRANT EXECUTE ON [sp_ssis_listfolders] TO [db_ssisltduser]
GRANT EXECUTE ON [sp_ssis_listfolders] TO [db_ssisoperator]
GO
