USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_mi_session_statistics_internal] (
    [collection_time] datetimeoffset NOT NULL -- PK
    ,[session_id] int NOT NULL -- PK
    ,[dac_instance_name] sysname NOT NULL -- PK
    ,[database_name] sysname NOT NULL -- PK
    ,[login_time] datetime NOT NULL -- PK
    ,[cumulative_cpu_ms] int NOT NULL

    ,CONSTRAINT [PK_sysutility_mi_session_statistics_internal]
        PRIMARY KEY ([collection_time], [session_id], [dac_instance_name], [database_name], [login_time])
)
GO

GRANT SELECT ON [sysutility_mi_session_statistics_internal] TO [UtilityIMRReader]
GRANT DELETE, INSERT ON [sysutility_mi_session_statistics_internal] TO [UtilityIMRWriter]
GO
