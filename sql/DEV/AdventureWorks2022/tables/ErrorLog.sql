USE [AdventureWorks2022]
GO

CREATE TABLE [dbo].[ErrorLog] (
    [ErrorLogID] int NOT NULL IDENTITY(1,1) -- PK
    ,[ErrorTime] datetime NOT NULL -- DF [getdate()]
    ,[UserName] sysname NOT NULL
    ,[ErrorNumber] int NOT NULL
    ,[ErrorSeverity] int NULL
    ,[ErrorState] int NULL
    ,[ErrorProcedure] nvarchar(126) NULL
    ,[ErrorLine] int NULL
    ,[ErrorMessage] nvarchar(4000) NOT NULL

    ,CONSTRAINT [PK_ErrorLog_ErrorLogID]
        PRIMARY KEY ([ErrorLogID])
)
GO

ALTER TABLE [dbo].[ErrorLog] ADD CONSTRAINT [DF_ErrorLog_ErrorTime]
    DEFAULT ((getdate())) FOR [ErrorTime]
GO
