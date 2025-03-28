USE [msdb]
GO

CREATE   TRIGGER trig_sysmail_profile_delete
ON msdb.dbo.sysmail_profile
FOR DELETE
AS
BEGIN
   DELETE FROM msdb.dbo.sysmail_profileaccount
   WHERE profile_id IN (SELECT profile_id FROM deleted)
END
GO
