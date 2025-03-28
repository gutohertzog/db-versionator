USE [msdb]
GO

CREATE   TRIGGER [sysmanagement_delete_shared_server_group_trigger] on [msdb].[dbo].[sysmanagement_shared_server_groups_internal]
FOR DELETE
AS
BEGIN
    -- system server groups should not be deleted
    IF EXISTS (SELECT * FROM deleted where is_system_object = 1)
    BEGIN
        RAISERROR (35008, 1, 1)
        ROLLBACK TRANSACTION
    END
END
GO
