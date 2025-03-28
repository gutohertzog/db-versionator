USE [msdb]
GO

CREATE   TRIGGER [dbo].[syspolicy_insert_policy_trigger] on [dbo].[syspolicy_policies_internal]
FOR INSERT
AS
BEGIN
    DECLARE @object_set_id int, @name sysname

	SELECT TOP 1 @object_set_id = i.object_set_id, @name = i.name
	FROM inserted i
	WHERE 1 < (SELECT count(*) FROM syspolicy_policies p WHERE p.object_set_id = i.object_set_id)

	IF @@ROWCOUNT > 0
	BEGIN
				DECLARE @os_name sysname, @policy_name sysname
				SELECT TOP 1 @os_name = os.object_set_name, @policy_name = p.name
				 FROM syspolicy_object_sets os
					INNER JOIN syspolicy_policies p ON (os.object_set_id = p.object_set_id)
				WHERE os.object_set_id = @object_set_id AND p.name <> @name

				RAISERROR(34013, -1, -1, 'ObjectSet', @os_name, @policy_name)
				ROLLBACK TRANSACTION
	END
END
GO
