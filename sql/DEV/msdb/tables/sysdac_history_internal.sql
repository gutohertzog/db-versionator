USE [msdb]
GO

CREATE TABLE [dbo].[sysdac_history_internal] (
    [action_id] int NOT NULL -- PK UK
    ,[sequence_id] int NOT NULL -- PK
    ,[instance_id] uniqueidentifier NOT NULL
    ,[action_type] tinyint NOT NULL -- UK
    ,[action_type_name] varchar(19) NULL
    ,[dac_object_type] tinyint NOT NULL -- UK
    ,[dac_object_type_name] varchar(8) NULL
    ,[action_status] tinyint NOT NULL
    ,[action_status_name] varchar(11) NULL
    ,[required] bit NULL
    ,[dac_object_name_pretran] sysname NOT NULL -- UK
    ,[dac_object_name_posttran] sysname NOT NULL -- UK
    ,[sqlscript] nvarchar(MAX) NULL
    ,[payload] varbinary(MAX) NULL
    ,[comments] varchar(MAX) NOT NULL
    ,[error_string] nvarchar(MAX) NULL
    ,[created_by] sysname NOT NULL -- DF [[dbo].[fn_sysdac_get_currentusername]()]
    ,[date_created] datetime NOT NULL -- DF [getdate()]
    ,[date_modified] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_sysdac_history_internal]
        PRIMARY KEY ([action_id], [sequence_id])

    ,CONSTRAINT [UQ_sysdac_history_internal]
        UNIQUE CLUSTERED ([action_id], [action_id], [dac_object_type], [action_type], [dac_object_name_pretran], [dac_object_name_posttran])
)
GO

ALTER TABLE [dbo].[sysdac_history_internal] ADD CONSTRAINT [DF__sysdac_hi__creat__2E46C4CB]
    DEFAULT (([dbo].[fn_sysdac_get_currentusername]())) FOR [created_by]
GO

ALTER TABLE [dbo].[sysdac_history_internal] ADD CONSTRAINT [DF__sysdac_hi__date___3A379A64]
    DEFAULT ((getdate())) FOR [date_created]
GO

ALTER TABLE [dbo].[sysdac_history_internal] ADD CONSTRAINT [DF__sysdac_hi__date___3B2BBE9D]
    DEFAULT ((getdate())) FOR [date_modified]
GO
