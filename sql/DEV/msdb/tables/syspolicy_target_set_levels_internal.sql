USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_target_set_levels_internal] (
    [target_set_level_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[target_set_id] int NOT NULL -- FK [syspolicy_target_sets_internal]
    ,[type_skeleton] nvarchar(440) NOT NULL
    ,[condition_id] int NULL -- FK [syspolicy_conditions_internal]
    ,[level_name] sysname NOT NULL

    ,CONSTRAINT [PK_syspolicy_target_set_levels_internal]
        PRIMARY KEY ([target_set_level_id])

    ,CONSTRAINT [FK_syspolicy_levels_conditions]
        FOREIGN KEY ([condition_id])
        REFERENCES [dbo].[syspolicy_conditions_internal] ([condition_id])

    ,CONSTRAINT [FK_syspolicy_levels_target_sets]
        FOREIGN KEY ([target_set_id])
        REFERENCES [dbo].[syspolicy_target_sets_internal] ([target_set_id])
)
GO
