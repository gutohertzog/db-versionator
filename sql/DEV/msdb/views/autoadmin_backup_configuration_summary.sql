USE [msdb]
GO

----------------------------------------------------------------------------------------------------
--                              autoadmin_backup_configuration_summary
--
-- Contains a summarized version of autoadmin_backup_configurations
-- This removes db_ids and outputs only count of databases with each configuration
--
CREATE   VIEW autoadmin_backup_configuration_summary
as
SELECT
	ManagedBackupVersion,
	IsAlwaysOn,
	IsDropped,
	IsEnabled,
	RetentionPeriod,
	EncryptionAlgorithm,
	SchedulingOption,
	DayOfWeek,
	COUNT(*) AS DatabaseCount
FROM autoadmin_backup_configurations
GROUP BY
	ManagedBackupVersion,
	IsAlwaysOn,
	IsDropped,
	IsEnabled,
	RetentionPeriod,
	EncryptionAlgorithm,
	SchedulingOption,
	DayOfWeek
GO

GRANT SELECT ON [autoadmin_backup_configuration_summary] TO [public]
GO
