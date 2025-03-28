USE [msdb]
GO

CREATE NONCLUSTERED INDEX [IX_syspolicy_system_health_state_internal_policy_id] ON [dbo].[syspolicy_system_health_state_internal]
(
    [policy_id]
)
GO
