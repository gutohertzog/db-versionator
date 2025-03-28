USE [msdb]
GO

CREATE TABLE [dbo].[sysdbmaintplan_history] (
    [sequence_id] int NOT NULL IDENTITY(1,1) -- UK
    ,[plan_id] uniqueidentifier NOT NULL -- DF ['00000000-0000-0000-0000-000000000000']
    ,[plan_name] sysname NOT NULL -- DF ['All ad-hoc plans']
    ,[database_name] sysname NULL
    ,[server_name] sysname NOT NULL -- DF [CONVERT[sysname],serverproperty'ServerName']
    ,[activity] nvarchar(128) NULL
    ,[succeeded] bit NOT NULL -- DF [1]
    ,[end_time] datetime NOT NULL -- DF [getdate()]
    ,[duration] int NULL -- DF [0]
    ,[start_time] datetime NULL
    ,[error_number] int NOT NULL -- DF [0]
    ,[message] nvarchar(512) NULL

    ,CONSTRAINT [UQ__sysdbmai__B2649B251BFD145F]
        UNIQUE CLUSTERED ([sequence_id], [sequence_id])
)
GO

ALTER TABLE [dbo].[sysdbmaintplan_history] ADD CONSTRAINT [DF__sysdbmain__durat__558AAF1E]
    DEFAULT (((0))) FOR [duration]
GO

ALTER TABLE [dbo].[sysdbmaintplan_history] ADD CONSTRAINT [DF__sysdbmain__end_t__54968AE5]
    DEFAULT ((getdate())) FOR [end_time]
GO

ALTER TABLE [dbo].[sysdbmaintplan_history] ADD CONSTRAINT [DF__sysdbmain__error__567ED357]
    DEFAULT (((0))) FOR [error_number]
GO

ALTER TABLE [dbo].[sysdbmaintplan_history] ADD CONSTRAINT [DF__sysdbmain__plan___50C5FA01]
    DEFAULT (('00000000-0000-0000-0000-000000000000')) FOR [plan_id]
GO

ALTER TABLE [dbo].[sysdbmaintplan_history] ADD CONSTRAINT [DF__sysdbmain__plan___51BA1E3A]
    DEFAULT (('All ad-hoc plans')) FOR [plan_name]
GO

ALTER TABLE [dbo].[sysdbmaintplan_history] ADD CONSTRAINT [DF__sysdbmain__serve__52AE4273]
    DEFAULT ((CONVERT([sysname],serverproperty('ServerName')))) FOR [server_name]
GO

ALTER TABLE [dbo].[sysdbmaintplan_history] ADD CONSTRAINT [DF__sysdbmain__succe__53A266AC]
    DEFAULT (((1))) FOR [succeeded]
GO
