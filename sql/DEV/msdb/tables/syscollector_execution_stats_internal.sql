USE [msdb]
GO

CREATE TABLE [dbo].[syscollector_execution_stats_internal] (
    [log_id] bigint NOT NULL -- PK FK [syscollector_execution_log_internal]
    ,[task_name] nvarchar(128) NOT NULL -- PK
    ,[execution_row_count_in] int NULL
    ,[execution_row_count_out] int NULL
    ,[execution_row_count_errors] int NULL
    ,[execution_time_ms] int NULL
    ,[log_time] datetime NOT NULL -- PK

    ,CONSTRAINT [PK_syscollector_execution_stats]
        PRIMARY KEY ([log_id], [task_name], [log_time])

    ,CONSTRAINT [FK_syscollector_execution_stats_log_id]
        FOREIGN KEY ([log_id])
        REFERENCES [dbo].[syscollector_execution_log_internal] ([log_id])
)
GO
