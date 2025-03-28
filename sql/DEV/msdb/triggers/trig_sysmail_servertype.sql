USE [msdb]
GO

CREATE   TRIGGER trig_sysmail_servertype
ON msdb.dbo.sysmail_servertype
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_servertype'), 'AFTER' , 'DML' ) <= 1)
   BEGIN
      UPDATE msdb.dbo.sysmail_servertype
      SET last_mod_datetime = getdate(),last_mod_user = suser_sname()
      FROM sysmail_servertype s, inserted i
      where s.servertype = i.servertype
   END
END
GO
