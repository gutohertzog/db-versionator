USE [msdb]
GO

CREATE   TRIGGER trig_sysmail_profile
ON msdb.dbo.sysmail_profile
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_profile'), 'AFTER' , 'DML' ) <= 1)
   BEGIN
      UPDATE msdb.dbo.sysmail_profile
      SET last_mod_datetime = getdate(),last_mod_user = suser_sname()
      FROM sysmail_profile p, inserted i
      WHERE p.profile_id = i.profile_id
   END
END
GO
