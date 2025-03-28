USE [msdb]
GO

CREATE   TRIGGER trig_sysmail_configuration
ON msdb.dbo.sysmail_configuration
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_configuration'), 'AFTER' , 'DML' ) <= 1)
   BEGIN
      UPDATE msdb.dbo.sysmail_configuration
      SET last_mod_datetime = getdate(),last_mod_user = suser_sname()
      FROM sysmail_configuration c, inserted i
      WHERE c.paramname = i.paramname
   END
END
GO
