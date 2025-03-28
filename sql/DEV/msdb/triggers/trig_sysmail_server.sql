USE [msdb]
GO

CREATE   TRIGGER trig_sysmail_server
ON msdb.dbo.sysmail_server
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_server'), 'AFTER' , 'DML' ) <= 1)
   BEGIN
      UPDATE msdb.dbo.sysmail_server
      SET last_mod_datetime = getdate(),last_mod_user = suser_sname()
      FROM sysmail_server s, inserted i
      WHERE s.account_id = i.account_id and s.servertype = i.servertype
   END
END
GO
