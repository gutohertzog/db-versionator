USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_mi_dac_execution_statistics_internal] (
    [dac_instance_name] sysname NOT NULL -- PK
    ,[database_name] sysname NOT NULL -- UK
    ,[database_id] int NOT NULL -- UK
    ,[date_created] datetime NULL
    ,[description] nvarchar(4000) NULL
    ,[first_collection_time] datetimeoffset NULL
    ,[last_collection_time] datetimeoffset NULL
    ,[last_upload_time] datetimeoffset NULL
    ,[lifetime_cpu_time_ms] bigint NULL
    ,[cpu_time_ms_at_last_upload] bigint NULL

    ,CONSTRAINT [PK_sysutility_mi_dac_execution_statistics_internal]
        PRIMARY KEY ([dac_instance_name])

    ,CONSTRAINT [UQ__sysutili__0717EC61013C6491]
        UNIQUE CLUSTERED ([database_name], [database_name])

    ,CONSTRAINT [UQ__sysutili__A5C7DBB7B04F4BE1]
        UNIQUE CLUSTERED ([database_id], [database_id])
)
GO

GRANT SELECT ON [sysutility_mi_dac_execution_statistics_internal] TO [UtilityIMRReader]
GRANT DELETE, INSERT ON [sysutility_mi_dac_execution_statistics_internal] TO [UtilityIMRWriter]
GO
