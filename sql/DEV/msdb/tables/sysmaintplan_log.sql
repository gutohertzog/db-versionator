USE [msdb]
GO

CREATE TABLE [dbo].[sysmaintplan_log] (
    [task_detail_id] uniqueidentifier NOT NULL -- PK
    ,[plan_id] uniqueidentifier NULL
    ,[subplan_id] uniqueidentifier NULL -- FK [sysmaintplan_subplans]
    ,[start_time] datetime NULL
    ,[end_time] datetime NULL
    ,[succeeded] bit NULL
    ,[logged_remotely] bit NOT NULL -- DF [0]
    ,[source_server_name] nvarchar(128) NULL
    ,[plan_name] nvarchar(128) NULL
    ,[subplan_name] nvarchar(128) NULL

    ,CONSTRAINT [PK_sysmaintplan_taskdetail_id]
        PRIMARY KEY ([task_detail_id])

    ,CONSTRAINT [FK_sysmaintplan_log_subplan_id]
        FOREIGN KEY ([subplan_id])
        REFERENCES [dbo].[sysmaintplan_subplans] ([subplan_id])
)
GO

ALTER TABLE [dbo].[sysmaintplan_log] ADD CONSTRAINT [DF__sysmaintp__logge__361203C5]
    DEFAULT (((0))) FOR [logged_remotely]
GO
