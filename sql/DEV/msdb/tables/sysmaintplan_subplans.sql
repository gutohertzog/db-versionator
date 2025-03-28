USE [msdb]
GO

CREATE TABLE [dbo].[sysmaintplan_subplans] (
    [subplan_id] uniqueidentifier NOT NULL -- PK
    ,[subplan_name] sysname NOT NULL
    ,[subplan_description] nvarchar(512) NULL
    ,[plan_id] uniqueidentifier NOT NULL
    ,[job_id] uniqueidentifier NOT NULL -- FK [sysjobs]
    ,[msx_job_id] uniqueidentifier NULL -- FK [sysjobs] DF [NULL]
    ,[schedule_id] int NULL -- FK [sysschedules]
    ,[msx_plan] bit NOT NULL -- DF [0]

    ,CONSTRAINT [PK_sysmaintplan_subplan]
        PRIMARY KEY ([subplan_id])

    ,CONSTRAINT [FK_subplan_job_id]
        FOREIGN KEY ([job_id])
        REFERENCES [dbo].[sysjobs] ([job_id])

    ,CONSTRAINT [FK_subplan_msx_job_id]
        FOREIGN KEY ([msx_job_id])
        REFERENCES [dbo].[sysjobs] ([job_id])

    ,CONSTRAINT [FK_subplan_schedule_id]
        FOREIGN KEY ([schedule_id])
        REFERENCES [dbo].[sysschedules] ([schedule_id])
)
GO

ALTER TABLE [dbo].[sysmaintplan_subplans] ADD CONSTRAINT [DF__sysmaintp__msx_j__2F650636]
    DEFAULT ((NULL)) FOR [msx_job_id]
GO

ALTER TABLE [dbo].[sysmaintplan_subplans] ADD CONSTRAINT [DF__sysmaintp__msx_p__324172E1]
    DEFAULT (((0))) FOR [msx_plan]
GO
