USE [msdb]
GO

CREATE CLUSTERED INDEX [IX_facet_events_target_type_alias] ON [dbo].[syspolicy_facet_events]
(
    [target_type_alias]
)
GO
