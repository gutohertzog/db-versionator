USE [msdb]
GO

CREATE   VIEW sysmail_sentitems
AS
SELECT * FROM msdb.dbo.sysmail_allitems WHERE sent_status = 'sent'
GO

GRANT SELECT ON [sysmail_sentitems] TO [DatabaseMailUserRole]
GO
