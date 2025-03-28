USE [msdb]
GO

CREATE TABLE [dbo].[MSdbms_datatype] (
    [datatype_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[dbms_id] int NOT NULL -- FK [MSdbms]
    ,[type] sysname NOT NULL
    ,[createparams] int NOT NULL -- DF [0]

    ,CONSTRAINT [pk_MSdbms_datatype]
        PRIMARY KEY ([datatype_id])

    ,CONSTRAINT [fk_MSdbms_datatype_dbms_id]
        FOREIGN KEY ([dbms_id])
        REFERENCES [dbo].[MSdbms] ([dbms_id])
)
GO

ALTER TABLE [dbo].[MSdbms_datatype] ADD CONSTRAINT [DF__MSdbms_da__creat__286302EC]
    DEFAULT (((0))) FOR [createparams]
GO
