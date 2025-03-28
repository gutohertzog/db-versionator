USE [msdb]
GO

CREATE TABLE [dbo].[autoadmin_task_agent_metadata] (
    [task_agent_guid] uniqueidentifier NOT NULL -- PK
    ,[autoadmin_id] bigint NOT NULL -- PK
    ,[last_modified] datetime NOT NULL
    ,[task_agent_data] xml NULL
    ,[schema_version] int NOT NULL -- DF [2]

    ,CONSTRAINT [autoadmin_task_agent_metadata_pk]
        PRIMARY KEY ([task_agent_guid], [autoadmin_id])
)
GO

ALTER TABLE [dbo].[autoadmin_task_agent_metadata] ADD CONSTRAINT [DF__autoadmin__schem__61DB776A]
    DEFAULT (((2))) FOR [schema_version]
GO
