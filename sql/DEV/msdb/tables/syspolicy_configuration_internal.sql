USE [msdb]
GO

CREATE TABLE [dbo].[syspolicy_configuration_internal] (
    [name] sysname NOT NULL -- PK
    ,[current_value] sql_variant NOT NULL

    ,CONSTRAINT [PK__syspolic__72E12F1A78A57DF8]
        PRIMARY KEY ([name])
)
GO
