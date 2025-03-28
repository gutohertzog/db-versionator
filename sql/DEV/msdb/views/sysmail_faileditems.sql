USE [msdb]
GO

CREATE   VIEW sysmail_faileditems
AS
SELECT * FROM msdb.dbo.sysmail_allitems WHERE sent_status = 'failed'
GO

GRANT SELECT ON [sysmail_faileditems] TO [DatabaseMailUserRole]
GO
