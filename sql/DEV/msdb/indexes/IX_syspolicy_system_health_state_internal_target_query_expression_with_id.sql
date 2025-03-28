USE [msdb]
GO

CREATE NONCLUSTERED INDEX [IX_syspolicy_system_health_state_internal_target_query_expression_with_id] ON [dbo].[syspolicy_system_health_state_internal]
(
    [target_query_expression_with_id]
)
GO
