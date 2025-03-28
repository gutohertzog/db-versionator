USE [msdb]
GO

/**********************************************************************/
/* Create view sysutility_ucp_mi_volume_space_health            */
/* This view returns the latest volume space health states for computers */
/**********************************************************************/

	CREATE   VIEW dbo.sysutility_ucp_mi_volume_space_health
	AS
	SELECT t.physical_server_name,
			t.server_instance_name,
			t.volume_device_id,
			t.health_state,
			t.processing_time
	FROM msdb.dbo.sysutility_ucp_mi_volume_space_health_internal AS t
	WHERE t.set_number = (SELECT latest_health_state_id FROM [msdb].[dbo].[sysutility_ucp_processing_state_internal])
GO

GRANT SELECT ON [sysutility_ucp_mi_volume_space_health] TO [UtilityCMRReader]
GO
