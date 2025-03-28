USE [msdb]
GO

CREATE TABLE [dbo].[syscollector_config_store_internal] (
    [parameter_name] nvarchar(128) NOT NULL -- PK
    ,[parameter_value] sql_variant NULL

    ,CONSTRAINT [PK_syscollector_config_store_internal_paremeter_name]
        PRIMARY KEY ([parameter_name])
)
GO
