USE [msdb]
GO

/**********************************************************************/
/* Create the health policy violations view                           */
/* This view fetches violations for health polices from latest policy evaluation */
/**********************************************************************/
CREATE   VIEW dbo.sysutility_ucp_policy_violations
AS
    SELECT pv.health_policy_id
        , pv.policy_id
        , pv.policy_name
        , pv.history_id
        , pv.detail_id
        , pv.target_query_expression
        , pv.target_query_expression_with_id
        , pv.execution_date
        , pv.result
    FROM dbo.sysutility_ucp_policy_violations_internal pv
GO

GRANT SELECT ON [sysutility_ucp_policy_violations] TO [UtilityCMRReader]
GO
