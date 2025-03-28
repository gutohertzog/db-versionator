USE [msdb]
GO

CREATE TABLE [dbo].[MSdbms] (
    [dbms_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[dbms] sysname NOT NULL
    ,[version] sysname NULL

    ,CONSTRAINT [pk_MSdbms]
        PRIMARY KEY ([dbms_id])
)
GO
