USE [msdb]
GO

/**********************************************************************/
/* Create view sysutility_ucp_mi_database_health               */
/* This view returns the latest database health states for MI's       */
/**********************************************************************/

	CREATE   VIEW dbo.sysutility_ucp_mi_database_health
	AS
	SELECT t.server_instance_name,
			t.database_name,
			(SELECT val FROM dbo.fn_sysutility_ucp_get_aggregated_health(t.over_utilized_count, t.under_utilized_count)) health_state,
			t.processing_time
	FROM msdb.dbo.sysutility_ucp_mi_database_health_internal AS t
	WHERE t.set_number = (SELECT latest_health_state_id FROM [msdb].[dbo].[sysutility_ucp_processing_state_internal])
GO

GRANT SELECT ON [sysutility_ucp_mi_database_health] TO [UtilityCMRReader]
GO
