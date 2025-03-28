USE [msdb]
GO

CREATE   PROCEDURE [dbo].[sp_syspolicy_delete_target_set]
@target_set_id int
AS
BEGIN
	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN @retval_check
	END

	DELETE msdb.[dbo].[syspolicy_target_sets_internal]
		WHERE target_set_id = @target_set_id

	IF (@@ROWCOUNT = 0)
	BEGIN
		DECLARE @target_set_id_as_char VARCHAR(36)
		SELECT @target_set_id_as_char = CONVERT(VARCHAR(36), @target_set_id)
		RAISERROR(14262, -1, -1, '@target_set_id', @target_set_id_as_char)
		RETURN (1)
	END

    RETURN (0)
END
GO
