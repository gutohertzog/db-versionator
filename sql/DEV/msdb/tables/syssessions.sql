USE [msdb]
GO

CREATE TABLE [dbo].[syssessions] (
    [session_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[agent_start_date] datetime NOT NULL

    ,CONSTRAINT [PK__syssessi__69B13FDC7D85A341]
        PRIMARY KEY ([session_id])
)
GO
