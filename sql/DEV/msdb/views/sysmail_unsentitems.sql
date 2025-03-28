USE [msdb]
GO

CREATE   VIEW sysmail_unsentitems
AS
SELECT * FROM msdb.dbo.sysmail_allitems WHERE (sent_status = 'unsent' OR sent_status = 'retrying')
GO

GRANT SELECT ON [sysmail_unsentitems] TO [DatabaseMailUserRole]
GO
