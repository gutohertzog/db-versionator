USE [msdb]
GO

CREATE TABLE [dbo].[syscollector_collection_sets_internal] (
    [collection_set_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[collection_set_uid] uniqueidentifier NOT NULL
    ,[schedule_uid] uniqueidentifier NULL
    ,[name] sysname NOT NULL -- UK
    ,[name_id] int NULL
    ,[target] nvarchar(MAX) NULL
    ,[is_running] bit NOT NULL -- DF [0]
    ,[proxy_id] int NULL -- FK [sysproxies]
    ,[is_system] bit NOT NULL
    ,[collection_job_id] uniqueidentifier NULL -- FK [sysjobs]
    ,[upload_job_id] uniqueidentifier NULL -- FK [sysjobs]
    ,[collection_mode] smallint NOT NULL -- DF [0]
    ,[logging_level] smallint NOT NULL -- DF [2]
    ,[description] nvarchar(4000) NULL
    ,[description_id] int NULL
    ,[days_until_expiration] smallint NOT NULL
    ,[dump_on_any_error] bit NOT NULL -- DF [0]
    ,[dump_on_codes] nvarchar(MAX) NULL

    ,CONSTRAINT [PK_syscollector_collection_sets_internal]
        PRIMARY KEY ([collection_set_id])

    ,CONSTRAINT [UQ_syscollector_collection_sets_internal_name]
        UNIQUE CLUSTERED ([name], [name])

    ,CONSTRAINT [FK_syscollector_collection_sets_collection_sysjobs]
        FOREIGN KEY ([collection_job_id])
        REFERENCES [dbo].[sysjobs] ([job_id])

    ,CONSTRAINT [FK_syscollector_collection_sets_internal_sysproxies]
        FOREIGN KEY ([proxy_id])
        REFERENCES [dbo].[sysproxies] ([proxy_id])

    ,CONSTRAINT [FK_syscollector_collection_sets_upload_sysjobs]
        FOREIGN KEY ([upload_job_id])
        REFERENCES [dbo].[sysjobs] ([job_id])
)
GO

ALTER TABLE [dbo].[syscollector_collection_sets_internal] ADD CONSTRAINT [DF__syscollec__colle__35DCF99B]
    DEFAULT (((0))) FOR [collection_mode]
GO

ALTER TABLE [dbo].[syscollector_collection_sets_internal] ADD CONSTRAINT [DF__syscollec__dump___37C5420D]
    DEFAULT (((0))) FOR [dump_on_any_error]
GO

ALTER TABLE [dbo].[syscollector_collection_sets_internal] ADD CONSTRAINT [DF__syscollec__is_ru__34E8D562]
    DEFAULT (((0))) FOR [is_running]
GO

ALTER TABLE [dbo].[syscollector_collection_sets_internal] ADD CONSTRAINT [DF__syscollec__loggi__36D11DD4]
    DEFAULT (((2))) FOR [logging_level]
GO
