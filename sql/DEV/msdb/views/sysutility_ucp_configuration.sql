USE [msdb]
GO

CREATE   VIEW [dbo].[sysutility_ucp_configuration]
AS
    SELECT
        name,
        current_value
    FROM [dbo].[sysutility_ucp_configuration_internal]
GO

GRANT SELECT ON [sysutility_ucp_configuration] TO [UtilityCMRReader]
GO
