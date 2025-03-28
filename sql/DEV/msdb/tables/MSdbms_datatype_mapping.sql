USE [msdb]
GO

CREATE TABLE [dbo].[MSdbms_datatype_mapping] (
    [datatype_mapping_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[map_id] int NOT NULL -- FK [MSdbms_map]
    ,[dest_datatype_id] int NOT NULL -- FK [MSdbms_datatype]
    ,[dest_precision] bigint NULL -- DF [NULL]
    ,[dest_scale] int NULL -- DF [NULL]
    ,[dest_length] bigint NULL -- DF [NULL]
    ,[dest_nullable] bit NULL -- DF [NULL]
    ,[dest_createparams] int NULL -- DF [0]
    ,[dataloss] bit NOT NULL -- DF [0]

    ,CONSTRAINT [pk_MSdbms_datatype_mapping]
        PRIMARY KEY ([datatype_mapping_id])

    ,CONSTRAINT [fk_MSdbms_datatype_mapping_dest_datatype_id]
        FOREIGN KEY ([dest_datatype_id])
        REFERENCES [dbo].[MSdbms_datatype] ([datatype_id])

    ,CONSTRAINT [fk_MSdbms_datatype_mapping_map_id]
        FOREIGN KEY ([map_id])
        REFERENCES [dbo].[MSdbms_map] ([map_id])
)
GO

ALTER TABLE [dbo].[MSdbms_datatype_mapping] ADD CONSTRAINT [DF__MSdbms_da__datal__3D5E1FD2]
    DEFAULT (((0))) FOR [dataloss]
GO

ALTER TABLE [dbo].[MSdbms_datatype_mapping] ADD CONSTRAINT [DF__MSdbms_da__dest___38996AB5]
    DEFAULT ((NULL)) FOR [dest_precision]
GO

ALTER TABLE [dbo].[MSdbms_datatype_mapping] ADD CONSTRAINT [DF__MSdbms_da__dest___398D8EEE]
    DEFAULT ((NULL)) FOR [dest_scale]
GO

ALTER TABLE [dbo].[MSdbms_datatype_mapping] ADD CONSTRAINT [DF__MSdbms_da__dest___3A81B327]
    DEFAULT ((NULL)) FOR [dest_length]
GO

ALTER TABLE [dbo].[MSdbms_datatype_mapping] ADD CONSTRAINT [DF__MSdbms_da__dest___3B75D760]
    DEFAULT ((NULL)) FOR [dest_nullable]
GO

ALTER TABLE [dbo].[MSdbms_datatype_mapping] ADD CONSTRAINT [DF__MSdbms_da__dest___3C69FB99]
    DEFAULT (((0))) FOR [dest_createparams]
GO
