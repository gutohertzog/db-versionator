USE [msdb]
GO

CREATE NONCLUSTERED INDEX [IX_syspolicy_policy_execution_history_internal_policy_id] ON [dbo].[syspolicy_policy_execution_history_internal]
(
    [policy_id]
)
GO
