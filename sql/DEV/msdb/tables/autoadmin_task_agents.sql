USE [msdb]
GO

CREATE TABLE [dbo].[autoadmin_task_agents] (
    [Id] int NOT NULL IDENTITY(1,1) -- PK
    ,[task_assembly_name] varchar(255) NOT NULL
    ,[task_assembly_path] varchar(MAX) NOT NULL
    ,[className] varchar(MAX) NOT NULL

    ,CONSTRAINT [PK__autoadmi__3214EC07C20BE71E]
        PRIMARY KEY ([Id])
)
GO
