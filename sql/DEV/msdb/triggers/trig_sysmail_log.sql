USE [msdb]
GO

CREATE   TRIGGER trig_sysmail_log
ON msdb.dbo.sysmail_log
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_log'), 'AFTER' , 'DML' ) <= 1)
   BEGIN
      UPDATE msdb.dbo.sysmail_log
      SET last_mod_date = GETDATE(), last_mod_user = SUSER_SNAME()
      FROM sysmail_log l, inserted i
      WHERE l.log_id = i.log_id
   END
END
GO
