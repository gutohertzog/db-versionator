USE [msdb]
GO

CREATE   VIEW [dbo].[syspolicy_target_sets]
AS
    SELECT
        target_set_id,
        object_set_id,
        type_skeleton,
        type,
        enabled
    FROM [dbo].[syspolicy_target_sets_internal]
GO

GRANT SELECT ON [syspolicy_target_sets] TO [PolicyAdministratorRole]
GRANT SELECT ON [syspolicy_target_sets] TO [public]
GO
