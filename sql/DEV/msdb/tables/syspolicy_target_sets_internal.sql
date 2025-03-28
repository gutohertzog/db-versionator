USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_target_sets_internal] (
    [target_set_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[object_set_id] int NOT NULL -- FK [syspolicy_object_sets_internal]
    ,[type_skeleton] nvarchar(440) NOT NULL
    ,[type] sysname NOT NULL
    ,[enabled] bit NOT NULL

    ,CONSTRAINT [PK_syspolicy_target_sets]
        PRIMARY KEY ([target_set_id])

    ,CONSTRAINT [FK_syspolicy_target_sets_syspolicy_object_sets]
        FOREIGN KEY ([object_set_id])
        REFERENCES [dbo].[syspolicy_object_sets_internal] ([object_set_id])
)
GO
