USE [msdb]
GO

CREATE TABLE [dbo].[sysschedules] (
    [schedule_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[schedule_uid] uniqueidentifier NOT NULL
    ,[originating_server_id] int NOT NULL
    ,[name] sysname NOT NULL
    ,[owner_sid] varbinary(85) NOT NULL
    ,[enabled] int NOT NULL
    ,[freq_type] int NOT NULL
    ,[freq_interval] int NOT NULL
    ,[freq_subday_type] int NOT NULL
    ,[freq_subday_interval] int NOT NULL
    ,[freq_relative_interval] int NOT NULL
    ,[freq_recurrence_factor] int NOT NULL
    ,[active_start_date] int NOT NULL
    ,[active_end_date] int NOT NULL
    ,[active_start_time] int NOT NULL
    ,[active_end_time] int NOT NULL
    ,[date_created] datetime NOT NULL -- DF [getdate()]
    ,[date_modified] datetime NOT NULL -- DF [getdate()]
    ,[version_number] int NOT NULL -- DF [1]

    ,CONSTRAINT [PK__syssched__C46A8A6FFF0E2D32]
        PRIMARY KEY ([schedule_id])
)
GO

ALTER TABLE [dbo].[sysschedules] ADD CONSTRAINT [DF__sysschedu__date___6EF57B66]
    DEFAULT ((getdate())) FOR [date_created]
GO

ALTER TABLE [dbo].[sysschedules] ADD CONSTRAINT [DF__sysschedu__date___6FE99F9F]
    DEFAULT ((getdate())) FOR [date_modified]
GO

ALTER TABLE [dbo].[sysschedules] ADD CONSTRAINT [DF__sysschedu__versi__70DDC3D8]
    DEFAULT (((1))) FOR [version_number]
GO
