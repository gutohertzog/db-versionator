USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_management_facets] (
    [management_facet_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[name] nvarchar(MAX) NOT NULL
    ,[execution_mode] int NOT NULL

    ,CONSTRAINT [PK__syspolic__66936FB426F4C2DC]
        PRIMARY KEY ([management_facet_id])
)
GO
