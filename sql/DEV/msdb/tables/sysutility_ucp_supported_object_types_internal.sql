USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_supported_object_types_internal] (
    [object_type] int NOT NULL -- PK
    ,[object_name] nvarchar(32) NULL

    ,CONSTRAINT [PK_sysutility_ucp_supported_object_types_internal]
        PRIMARY KEY ([object_type])
)
GO
