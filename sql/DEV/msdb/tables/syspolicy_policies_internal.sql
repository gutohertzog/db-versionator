USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_policies_internal] (
    [policy_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[name] sysname NOT NULL -- UK
    ,[condition_id] int NOT NULL -- FK [syspolicy_conditions_internal]
    ,[root_condition_id] int NULL -- FK [syspolicy_conditions_internal]
    ,[date_created] datetime NOT NULL -- DF [getdate()]
    ,[execution_mode] int NOT NULL -- DF [0]
    ,[policy_category_id] int NULL -- FK [syspolicy_policy_categories_internal]
    ,[schedule_uid] uniqueidentifier NULL
    ,[description] nvarchar(MAX) NOT NULL -- DF ['']
    ,[help_text] nvarchar(4000) NOT NULL -- DF ['']
    ,[help_link] nvarchar(2083) NOT NULL -- DF ['']
    ,[object_set_id] int NULL -- FK [syspolicy_object_sets_internal]
    ,[is_enabled] bit NOT NULL -- DF [0]
    ,[job_id] uniqueidentifier NULL -- FK [sysjobs]
    ,[created_by] sysname NOT NULL -- DF [suser_sname()]
    ,[modified_by] sysname NULL
    ,[date_modified] datetime NULL
    ,[is_system] bit NOT NULL -- DF [0]

    ,CONSTRAINT [PK_syspolicy_policies]
        PRIMARY KEY ([policy_id])

    ,CONSTRAINT [UQ_syspolicy_policies_name]
        UNIQUE CLUSTERED ([name], [name])

    ,CONSTRAINT [FK_syspolicy_policies_sysjobs]
        FOREIGN KEY ([job_id])
        REFERENCES [dbo].[sysjobs] ([job_id])

    ,CONSTRAINT [FK_syspolicy_policies_syspolicy_conditions]
        FOREIGN KEY ([condition_id])
        REFERENCES [dbo].[syspolicy_conditions_internal] ([condition_id])

    ,CONSTRAINT [FK_syspolicy_policies_syspolicy_object_sets]
        FOREIGN KEY ([object_set_id])
        REFERENCES [dbo].[syspolicy_object_sets_internal] ([object_set_id])

    ,CONSTRAINT [FK_syspolicy_policies_syspolicy_policy_categories]
        FOREIGN KEY ([policy_category_id])
        REFERENCES [dbo].[syspolicy_policy_categories_internal] ([policy_category_id])

    ,CONSTRAINT [FK_syspolicy_policies_syspolicy_root_conditions]
        FOREIGN KEY ([root_condition_id])
        REFERENCES [dbo].[syspolicy_conditions_internal] ([condition_id])
)
GO

ALTER TABLE [dbo].[syspolicy_policies_internal] ADD CONSTRAINT [DF__syspolicy__creat__4C8B54C9]
    DEFAULT ((suser_sname())) FOR [created_by]
GO

ALTER TABLE [dbo].[syspolicy_policies_internal] ADD CONSTRAINT [DF__syspolicy__date___46D27B73]
    DEFAULT ((getdate())) FOR [date_created]
GO

ALTER TABLE [dbo].[syspolicy_policies_internal] ADD CONSTRAINT [DF__syspolicy__descr__48BAC3E5]
    DEFAULT (('')) FOR [description]
GO

ALTER TABLE [dbo].[syspolicy_policies_internal] ADD CONSTRAINT [DF__syspolicy__execu__47C69FAC]
    DEFAULT (((0))) FOR [execution_mode]
GO

ALTER TABLE [dbo].[syspolicy_policies_internal] ADD CONSTRAINT [DF__syspolicy__help___49AEE81E]
    DEFAULT (('')) FOR [help_text]
GO

ALTER TABLE [dbo].[syspolicy_policies_internal] ADD CONSTRAINT [DF__syspolicy__help___4AA30C57]
    DEFAULT (('')) FOR [help_link]
GO

ALTER TABLE [dbo].[syspolicy_policies_internal] ADD CONSTRAINT [DF__syspolicy__is_en__4B973090]
    DEFAULT (((0))) FOR [is_enabled]
GO

ALTER TABLE [dbo].[syspolicy_policies_internal] ADD CONSTRAINT [DF__syspolicy__is_sy__4D7F7902]
    DEFAULT (((0))) FOR [is_system]
GO
