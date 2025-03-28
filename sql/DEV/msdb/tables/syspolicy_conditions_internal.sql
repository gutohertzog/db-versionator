USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_conditions_internal] (
    [condition_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[name] sysname NOT NULL -- UK
    ,[date_created] datetime NULL -- DF [getdate()]
    ,[description] nvarchar(MAX) NOT NULL -- DF ['']
    ,[created_by] sysname NOT NULL -- DF [suser_sname()]
    ,[modified_by] sysname NULL
    ,[date_modified] datetime NULL
    ,[facet_id] int NULL -- FK [syspolicy_management_facets]
    ,[expression] nvarchar(MAX) NULL
    ,[is_name_condition] smallint NULL -- DF [0]
    ,[obj_name] sysname NULL
    ,[is_system] bit NOT NULL -- DF [0]

    ,CONSTRAINT [PK_syspolicy_conditions]
        PRIMARY KEY ([condition_id])

    ,CONSTRAINT [UQ_syspolicy_conditions_name]
        UNIQUE CLUSTERED ([name], [name])

    ,CONSTRAINT [FK_syspolicy_conditions_internal_facet]
        FOREIGN KEY ([facet_id])
        REFERENCES [dbo].[syspolicy_management_facets] ([management_facet_id])
)
GO

ALTER TABLE [dbo].[syspolicy_conditions_internal] ADD CONSTRAINT [DF__syspolicy__creat__2B2A60FE]
    DEFAULT ((suser_sname())) FOR [created_by]
GO

ALTER TABLE [dbo].[syspolicy_conditions_internal] ADD CONSTRAINT [DF__syspolicy__date___2942188C]
    DEFAULT ((getdate())) FOR [date_created]
GO

ALTER TABLE [dbo].[syspolicy_conditions_internal] ADD CONSTRAINT [DF__syspolicy__descr__2A363CC5]
    DEFAULT (('')) FOR [description]
GO

ALTER TABLE [dbo].[syspolicy_conditions_internal] ADD CONSTRAINT [DF__syspolicy__is_na__2C1E8537]
    DEFAULT (((0))) FOR [is_name_condition]
GO

ALTER TABLE [dbo].[syspolicy_conditions_internal] ADD CONSTRAINT [DF__syspolicy__is_sy__2D12A970]
    DEFAULT (((0))) FOR [is_system]
GO
