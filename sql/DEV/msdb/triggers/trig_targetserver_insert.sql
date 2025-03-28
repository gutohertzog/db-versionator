USE [msdb]
GO

CREATE   TRIGGER trig_targetserver_insert
ON msdb.dbo.systargetservers
FOR INSERT, DELETE
AS
BEGIN
  SET NOCOUNT ON

  -- Disallow the insert if the server is called 'ALL'
  -- NOTE: We have to do this check here in the trigger since there is no sp_add_targetserver
  --       (target servers insert a row for themselves when they 'enlist' in an MSX)
  IF (EXISTS (SELECT *
              FROM inserted
              WHERE (server_name = N'ALL')))
  BEGIN
    DELETE FROM msdb.dbo.systargetservers
    WHERE (server_name = N'ALL')
    RAISERROR(14271, -1, -1, 'ALL')
    RETURN
  END

  -- Set (or delete) the registy flag (so that SETUP can detect if we're an MSX)
  IF ((SELECT COUNT(*)
       FROM msdb.dbo.systargetservers) = 0)
  BEGIN
    DECLARE @val INT

    EXECUTE master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE',
                                           N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
                                           N'MSXServer',
                                           @val OUTPUT,
                                           N'no_output'
    IF (@val IS NOT NULL)
      EXECUTE master.dbo.xp_instance_regdeletevalue N'HKEY_LOCAL_MACHINE',
                                                    N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
                                                    N'MSXServer'
  END
  ELSE
    EXECUTE master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE',
                                            N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
                                            N'MSXServer',
                                            N'REG_DWORD',
                                            1
END
GO
