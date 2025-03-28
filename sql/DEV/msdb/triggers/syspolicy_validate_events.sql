USE [msdb]
GO

CREATE TRIGGER [syspolicy_validate_events] on [dbo].[syspolicy_facet_events]
AFTER INSERT, UPDATE
AS
BEGIN
    -- make sure that caller is dbo and all events inserted are real events.
    IF  (USER_ID() != 1) OR
        EXISTS (SELECT event_name FROM inserted
                    WHERE event_name NOT IN(SELECT type_name from sys.event_notification_event_types))
    BEGIN
        RAISERROR(N'Unknown event name inserted into [dbo].[syspolicy_facet_events]', 1,1)
        ROLLBACK TRANSACTION
    END
END
GO
