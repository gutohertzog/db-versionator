USE [msdb]
GO

CREATE   TRIGGER dbo.trig_sysschedules_insert_update
ON dbo.sysschedules
FOR INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON
  -- Disallow the insert or update if the originating_server_id isn't in sysoriginatingservers_view.
  IF (EXISTS (SELECT *
            FROM inserted
           WHERE inserted.originating_server_id NOT IN
                    (SELECT v.originating_server_id
                     FROM sysoriginatingservers_view AS v)))
  BEGIN
   RAISERROR(14379, -1, -1, 'dbo.sysschedules')
   ROLLBACK TRANSACTION
    RETURN
  END
END
GO
