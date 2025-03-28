USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_managed_instances_internal] (
    [instance_id] int NOT NULL IDENTITY(1,1) -- UK
    ,[instance_name] sysname NOT NULL -- PK
    ,[virtual_server_name] sysname NOT NULL
    ,[date_created] datetimeoffset NOT NULL -- DF [sysdatetimeoffset()]
    ,[created_by] sysname NOT NULL -- DF [suser_sname()]
    ,[agent_proxy_account] sysname NOT NULL
    ,[cache_directory] nvarchar(520) NULL
    ,[management_state] int NOT NULL -- DF [0]

    ,CONSTRAINT [PK_sysutility_ucp_mi_name]
        PRIMARY KEY ([instance_name])

    ,CONSTRAINT [UQ_sysutility_ucp_mi_id]
        UNIQUE CLUSTERED ([instance_id], [instance_id])
)
GO

ALTER TABLE [dbo].[sysutility_ucp_managed_instances_internal] ADD CONSTRAINT [DF__sysutilit__creat__316D4A39]
    DEFAULT ((suser_sname())) FOR [created_by]
GO

ALTER TABLE [dbo].[sysutility_ucp_managed_instances_internal] ADD CONSTRAINT [DF__sysutilit__date___30792600]
    DEFAULT ((sysdatetimeoffset())) FOR [date_created]
GO

ALTER TABLE [dbo].[sysutility_ucp_managed_instances_internal] ADD CONSTRAINT [DF__sysutilit__manag__32616E72]
    DEFAULT (((0))) FOR [management_state]
GO

GRANT SELECT ON [sysutility_ucp_managed_instances_internal] TO [UtilityCMRReader]
GO
