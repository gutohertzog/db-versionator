USE [msdb]
GO

CREATE TABLE [dbo].[sysssislog] (
    [id] int NOT NULL IDENTITY(1,1) -- PK
    ,[event] sysname NOT NULL
    ,[computer] nvarchar(128) NOT NULL
    ,[operator] nvarchar(128) NOT NULL
    ,[source] nvarchar(1024) NOT NULL
    ,[sourceid] uniqueidentifier NOT NULL
    ,[executionid] uniqueidentifier NOT NULL
    ,[starttime] datetime NOT NULL
    ,[endtime] datetime NOT NULL
    ,[datacode] int NOT NULL
    ,[databytes] image NULL
    ,[message] nvarchar(2048) NOT NULL

    ,CONSTRAINT [PK__sysssisl__3213E83FF81F0996]
        PRIMARY KEY ([id])
)
GO

GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [sysssislog] TO [db_ssisadmin]
GRANT INSERT, SELECT ON [sysssislog] TO [db_ssisltduser]
GRANT INSERT, SELECT ON [sysssislog] TO [db_ssisoperator]
GO
