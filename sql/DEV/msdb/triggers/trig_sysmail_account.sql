USE [msdb]
GO

CREATE   TRIGGER trig_sysmail_account
ON msdb.dbo.sysmail_account
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_account'), 'AFTER' , 'DML' ) <= 1)
   BEGIN
      UPDATE msdb.dbo.sysmail_account
      SET last_mod_datetime = getdate(),last_mod_user = suser_sname()
      FROM sysmail_account a, inserted i
      WHERE a.account_id = i.account_id
   END
END
GO
