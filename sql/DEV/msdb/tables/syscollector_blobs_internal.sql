USE [msdb]
GO

CREATE TABLE [dbo].[syscollector_blobs_internal] (
    [parameter_name] nvarchar(128) NOT NULL -- PK
    ,[parameter_value] varbinary(MAX) NOT NULL

    ,CONSTRAINT [PK_syscollector_blobs_internal_paremeter_name]
        PRIMARY KEY ([parameter_name])
)
GO
