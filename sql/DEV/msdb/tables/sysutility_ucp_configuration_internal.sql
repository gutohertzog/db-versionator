USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_configuration_internal] (
    [name] sysname NOT NULL -- PK
    ,[current_value] sql_variant NULL

    ,CONSTRAINT [PK__sysutili__72E12F1A63D9031D]
        PRIMARY KEY ([name])
)
GO

GRANT SELECT ON [sysutility_ucp_configuration_internal] TO [UtilityCMRReader]
GO
