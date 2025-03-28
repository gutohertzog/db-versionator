USE [msdb]
GO

CREATE   VIEW [dbo].[syspolicy_object_sets]
AS
    SELECT
        os.object_set_id,
        os.object_set_name,
        os.facet_id,
        facet.name as facet_name,
        os.is_system
    FROM [dbo].[syspolicy_object_sets_internal] AS os INNER JOIN [dbo].[syspolicy_management_facets] AS facet
    ON os.facet_id = facet.management_facet_id
GO

GRANT SELECT ON [syspolicy_object_sets] TO [PolicyAdministratorRole]
GRANT SELECT ON [syspolicy_object_sets] TO [public]
GO
