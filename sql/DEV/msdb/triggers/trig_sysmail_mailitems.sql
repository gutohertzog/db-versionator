USE [msdb]
GO

-------------------------------------------------------------------------
-- Database Mail: triggers on general mail host database specific tables
-------------------------------------------------------------------------
CREATE   TRIGGER trig_sysmail_mailitems
ON msdb.dbo.sysmail_mailitems
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_mailitems'), 'AFTER' , 'DML' ) <= 1)
   BEGIN
      UPDATE msdb.dbo.sysmail_mailitems
      SET last_mod_date = GETDATE(), last_mod_user = SUSER_SNAME()
      FROM sysmail_mailitems m, inserted i
      WHERE m.mailitem_id = i.mailitem_id
   END
END
GO
