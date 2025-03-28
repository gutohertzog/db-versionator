USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_facet_events] (
    [management_facet_id] int NOT NULL -- FK [syspolicy_management_facets]
    ,[event_name] sysname NOT NULL
    ,[target_type] sysname NOT NULL
    ,[target_type_alias] sysname NOT NULL

    ,CONSTRAINT [FK__syspolicy__manag__247D636F]
        FOREIGN KEY ([management_facet_id])
        REFERENCES [dbo].[syspolicy_management_facets] ([management_facet_id])
)
GO
