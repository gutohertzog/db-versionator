USE [AdventureWorks2022]
GO

CREATE TABLE [dbo].[DatabaseLog] (
    [DatabaseLogID] int NOT NULL IDENTITY(1,1) -- PK
    ,[PostTime] datetime NOT NULL
    ,[DatabaseUser] sysname NOT NULL
    ,[Event] sysname NOT NULL
    ,[Schema] sysname NULL
    ,[Object] sysname NULL
    ,[TSQL] nvarchar(MAX) NOT NULL
    ,[XmlEvent] xml NOT NULL

    ,CONSTRAINT [PK_DatabaseLog_DatabaseLogID]
        PRIMARY KEY ([DatabaseLogID])
)
GO
