USE [msdb]
GO

CREATE TABLE [dbo].[syscategories] (
    [category_id] int NOT NULL IDENTITY(1,1)
    ,[category_class] int NOT NULL
    ,[category_type] tinyint NOT NULL
    ,[name] sysname NOT NULL
)
GO

GRANT SELECT ON [syscategories] TO [SQLAgentUserRole]
GO
