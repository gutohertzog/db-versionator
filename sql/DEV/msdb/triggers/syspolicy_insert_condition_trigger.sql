USE [msdb]
GO

CREATE   TRIGGER dbo.syspolicy_insert_condition_trigger
ON msdb.dbo.syspolicy_conditions_internal
AFTER INSERT
AS
BEGIN
	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN;
	END

  UPDATE msdb.dbo.syspolicy_conditions_internal
  SET created_by = original_login()
  FROM inserted i INNER JOIN
       msdb.dbo.syspolicy_conditions_internal conditions
  ON i.condition_id = conditions.condition_id

END
GO
