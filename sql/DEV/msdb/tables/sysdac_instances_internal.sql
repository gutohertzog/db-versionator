USE [msdb]
GO

CREATE TABLE [dbo].[sysdac_instances_internal] (
    [instance_id] uniqueidentifier NOT NULL -- PK
    ,[instance_name] sysname NOT NULL -- UK
    ,[type_name] sysname NOT NULL
    ,[type_version] nvarchar(64) NOT NULL
    ,[description] nvarchar(4000) NULL -- DF ['']
    ,[type_stream] varbinary(MAX) NOT NULL
    ,[date_created] datetime NOT NULL -- DF [getdate()]
    ,[created_by] sysname NOT NULL -- DF [[dbo].[fn_sysdac_get_currentusername]()]

    ,CONSTRAINT [PK_sysdac_instances_internal]
        PRIMARY KEY ([instance_id])

    ,CONSTRAINT [UQ_sysdac_instances_internal]
        UNIQUE CLUSTERED ([instance_name], [instance_name])
)
GO

ALTER TABLE [dbo].[sysdac_instances_internal] ADD CONSTRAINT [DF__sysdac_in__creat__2D52A092]
    DEFAULT (([dbo].[fn_sysdac_get_currentusername]())) FOR [created_by]
GO

ALTER TABLE [dbo].[sysdac_instances_internal] ADD CONSTRAINT [DF__sysdac_in__date___347EC10E]
    DEFAULT ((getdate())) FOR [date_created]
GO

ALTER TABLE [dbo].[sysdac_instances_internal] ADD CONSTRAINT [DF__sysdac_in__descr__338A9CD5]
    DEFAULT (('')) FOR [description]
GO
