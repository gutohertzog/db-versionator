USE [msdb]
GO

CREATE   TRIGGER dbo.trig_sysoriginatingservers_delete
ON dbo.sysoriginatingservers
FOR DELETE
AS
BEGIN
  SET NOCOUNT ON
  -- Only a single MSX server entry can exist in this table. ie. originating_server_id = 1 and master_server = 1.
  IF((EXISTS (SELECT *
           FROM deleted AS d
                JOIN dbo.sysjobs AS j ON d.originating_server_id = j.originating_server_id)) OR
    (EXISTS (SELECT *
           FROM deleted AS d
                JOIN dbo.sysschedules AS s ON d.originating_server_id = s.originating_server_id)))
  BEGIN
    RAISERROR(14380, -1, -1)
   ROLLBACK TRANSACTION
    RETURN
  END
END
GO
