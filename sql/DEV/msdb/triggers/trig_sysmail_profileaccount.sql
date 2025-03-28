USE [msdb]
GO

CREATE   TRIGGER trig_sysmail_profileaccount
ON msdb.dbo.sysmail_profileaccount
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_profileaccount'), 'AFTER' , 'DML' ) <= 1)
   BEGIN
      UPDATE msdb.dbo.sysmail_profileaccount
      SET last_mod_datetime = getdate(),last_mod_user = suser_sname()
      FROM sysmail_profileaccount p, inserted i
      WHERE p.profile_id = i.profile_id and p.account_id = i.account_id
   END
END
GO
