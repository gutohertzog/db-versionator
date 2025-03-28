USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_processing_state_internal] (
    [latest_processing_time] datetimeoffset NULL
    ,[latest_health_state_id] int NULL
    ,[next_health_state_id] int NULL
    ,[id] int NOT NULL -- PK

    ,CONSTRAINT [PK_sysutility_ucp_processing_state_internal]
        PRIMARY KEY ([id])
)
GO

GRANT SELECT ON [sysutility_ucp_processing_state_internal] TO [UtilityCMRReader]
GO
