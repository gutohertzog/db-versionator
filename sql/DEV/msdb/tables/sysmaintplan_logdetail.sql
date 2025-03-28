USE [msdb]
GO

CREATE TABLE [dbo].[sysmaintplan_logdetail] (
    [task_detail_id] uniqueidentifier NOT NULL -- FK [sysmaintplan_log]
    ,[line1] nvarchar(256) NOT NULL
    ,[line2] nvarchar(256) NULL
    ,[line3] nvarchar(256) NULL
    ,[line4] nvarchar(256) NULL
    ,[line5] nvarchar(256) NULL
    ,[server_name] sysname NOT NULL
    ,[start_time] datetime NULL
    ,[end_time] datetime NULL
    ,[error_number] int NULL
    ,[error_message] nvarchar(MAX) NULL
    ,[command] nvarchar(MAX) NULL
    ,[succeeded] bit NULL

    ,CONSTRAINT [FK_sysmaintplan_log_detail_task_id]
        FOREIGN KEY ([task_detail_id])
        REFERENCES [dbo].[sysmaintplan_log] ([task_detail_id])
)
GO
