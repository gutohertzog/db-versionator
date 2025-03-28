USE [msdb]
GO

CREATE   PROCEDURE [dbo].[sp_ssis_listpackages]
  @folderid uniqueidentifier
AS
  SELECT
      name,
      id,
      description,
      createdate,
      folderid,
      datalength(packagedata),
      vermajor,
      verminor,
      verbuild,
      vercomments,
      verid
  FROM
      sysssispackages
  WHERE
      [folderid] = @folderid
  ORDER BY
      name
GO

GRANT EXECUTE ON [sp_ssis_listpackages] TO [db_ssisadmin]
GRANT EXECUTE ON [sp_ssis_listpackages] TO [db_ssisltduser]
GRANT EXECUTE ON [sp_ssis_listpackages] TO [db_ssisoperator]
GO
