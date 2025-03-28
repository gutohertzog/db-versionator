USE [msdb]
GO

CREATE TABLE [dbo].[syscollector_collector_types_internal] (
    [collector_type_uid] uniqueidentifier NOT NULL -- PK
    ,[name] sysname NOT NULL -- UK
    ,[parameter_schema] xml NULL
    ,[parameter_formatter] xml NULL
    ,[schema_collection] sysname NULL
    ,[collection_package_name] sysname NOT NULL -- FK [sysssispackages]
    ,[collection_package_folderid] uniqueidentifier NOT NULL -- FK [sysssispackages]
    ,[upload_package_name] sysname NOT NULL -- FK [sysssispackages]
    ,[upload_package_folderid] uniqueidentifier NOT NULL -- FK [sysssispackages]
    ,[is_system] bit NOT NULL -- DF [0]

    ,CONSTRAINT [PK_syscollector_collector_types_internal]
        PRIMARY KEY ([collector_type_uid])

    ,CONSTRAINT [UQ_syscollector_collection_types_internal_name]
        UNIQUE CLUSTERED ([name], [name])

    ,CONSTRAINT [FK_syscollector_collector_types_internal_collection_sysssispackages]
        FOREIGN KEY ([collection_package_folderid], [collection_package_name])
        REFERENCES [dbo].[sysssispackages] ([folderid], [name])

    ,CONSTRAINT [FK_syscollector_collector_types_internal_upload_sysssispackages]
        FOREIGN KEY ([upload_package_folderid], [upload_package_name])
        REFERENCES [dbo].[sysssispackages] ([folderid], [name])
)
GO

ALTER TABLE [dbo].[syscollector_collector_types_internal] ADD CONSTRAINT [DF__syscollec__is_sy__46136164]
    DEFAULT (((0))) FOR [is_system]
GO
