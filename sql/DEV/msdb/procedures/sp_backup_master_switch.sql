USE [msdb]
GO

CREATE   PROCEDURE smart_admin.sp_backup_master_switch
	@new_state bit
AS
BEGIN
	EXECUTE [managed_backup].[sp_backup_master_switch] @new_state
END
GO
