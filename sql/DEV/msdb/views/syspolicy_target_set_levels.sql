USE [msdb]
GO

CREATE   VIEW [dbo].[syspolicy_target_set_levels]
AS
    SELECT
        target_set_level_id,
        target_set_id,
        type_skeleton,
        condition_id,
        level_name
    FROM [dbo].[syspolicy_target_set_levels_internal]
GO

GRANT SELECT ON [syspolicy_target_set_levels] TO [PolicyAdministratorRole]
GRANT SELECT ON [syspolicy_target_set_levels] TO [public]
GO
