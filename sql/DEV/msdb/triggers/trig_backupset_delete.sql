USE [msdb]
GO

CREATE   TRIGGER trig_backupset_delete ON msdb.dbo.backupset FOR DELETE AS
BEGIN
  DELETE FROM msdb.dbo.logmarkhistory from deleted
  WHERE (msdb.dbo.logmarkhistory.database_name = deleted.database_name)
    AND (msdb.dbo.logmarkhistory.lsn >= deleted.first_lsn)
    AND (msdb.dbo.logmarkhistory.lsn < deleted.last_lsn)
END
GO
