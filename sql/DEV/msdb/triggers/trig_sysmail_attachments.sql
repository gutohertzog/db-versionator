USE [msdb]
GO

CREATE   TRIGGER trig_sysmail_attachments
ON msdb.dbo.sysmail_attachments
FOR UPDATE
AS
BEGIN
   SET NOCOUNT ON

   IF (TRIGGER_NESTLEVEL( OBJECT_ID('dbo.trig_sysmail_attachments'), 'AFTER' , 'DML' ) <= 1)
   BEGIN
      UPDATE msdb.dbo.sysmail_attachments
      SET last_mod_date = GETDATE(), last_mod_user = SUSER_SNAME()
      FROM sysmail_attachments a, inserted i
      WHERE a.attachment_id = i.attachment_id
   END
END
GO
