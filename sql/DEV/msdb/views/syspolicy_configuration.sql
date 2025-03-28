USE [msdb]
GO

CREATE   VIEW [dbo].[syspolicy_configuration]
AS
    SELECT
        name,
        CASE WHEN name = N'Enabled' and (SERVERPROPERTY('EngineEdition') = 4 or SERVERPROPERTY('EngineEdition') = 9) THEN 0 ELSE current_value END AS current_value
    FROM [dbo].[syspolicy_configuration_internal]
GO

GRANT SELECT ON [syspolicy_configuration] TO [PolicyAdministratorRole]
GRANT SELECT ON [syspolicy_configuration] TO [public]
GO
