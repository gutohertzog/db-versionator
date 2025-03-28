USE [msdb]
GO

CREATE TABLE [dbo].[sysnotifications] (
    [alert_id] int NOT NULL
    ,[operator_id] int NOT NULL
    ,[notification_method] tinyint NOT NULL
)
GO

GRANT SELECT ON [sysnotifications] TO [SQLAgentOperatorRole]
GO
