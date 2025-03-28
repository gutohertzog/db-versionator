USE [msdb]
GO

CREATE TABLE [dbo].[MSdbms_map] (
    [map_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[src_dbms_id] int NOT NULL -- FK [MSdbms]
    ,[dest_dbms_id] int NOT NULL -- FK [MSdbms]
    ,[src_datatype_id] int NOT NULL -- FK [MSdbms_datatype]
    ,[src_len_min] bigint NULL -- DF [NULL]
    ,[src_len_max] bigint NULL -- DF [NULL]
    ,[src_prec_min] bigint NULL -- DF [NULL]
    ,[src_prec_max] bigint NULL -- DF [NULL]
    ,[src_scale_min] bigint NULL -- DF [NULL]
    ,[src_scale_max] bigint NULL -- DF [NULL]
    ,[src_nullable] bit NULL -- DF [NULL]
    ,[default_datatype_mapping_id] int NULL -- FK [MSdbms_datatype_mapping] DF [NULL]

    ,CONSTRAINT [pk_MSdbms_map]
        PRIMARY KEY ([map_id])

    ,CONSTRAINT [fk_MSdbms_map_default_datatype_mapping_id]
        FOREIGN KEY ([default_datatype_mapping_id])
        REFERENCES [dbo].[MSdbms_datatype_mapping] ([datatype_mapping_id])

    ,CONSTRAINT [fk_MSdbms_map_dest_dbms_id]
        FOREIGN KEY ([dest_dbms_id])
        REFERENCES [dbo].[MSdbms] ([dbms_id])

    ,CONSTRAINT [fk_MSdbms_map_src_datatype_id]
        FOREIGN KEY ([src_datatype_id])
        REFERENCES [dbo].[MSdbms_datatype] ([datatype_id])

    ,CONSTRAINT [fk_MSdbms_map_src_dbms_id]
        FOREIGN KEY ([src_dbms_id])
        REFERENCES [dbo].[MSdbms] ([dbms_id])
)
GO

ALTER TABLE [dbo].[MSdbms_map] ADD CONSTRAINT [DF__MSdbms_ma__defau__32E0915F]
    DEFAULT ((NULL)) FOR [default_datatype_mapping_id]
GO

ALTER TABLE [dbo].[MSdbms_map] ADD CONSTRAINT [DF__MSdbms_ma__src_l__2C3393D0]
    DEFAULT ((NULL)) FOR [src_len_min]
GO

ALTER TABLE [dbo].[MSdbms_map] ADD CONSTRAINT [DF__MSdbms_ma__src_l__2D27B809]
    DEFAULT ((NULL)) FOR [src_len_max]
GO

ALTER TABLE [dbo].[MSdbms_map] ADD CONSTRAINT [DF__MSdbms_ma__src_n__31EC6D26]
    DEFAULT ((NULL)) FOR [src_nullable]
GO

ALTER TABLE [dbo].[MSdbms_map] ADD CONSTRAINT [DF__MSdbms_ma__src_p__2E1BDC42]
    DEFAULT ((NULL)) FOR [src_prec_min]
GO

ALTER TABLE [dbo].[MSdbms_map] ADD CONSTRAINT [DF__MSdbms_ma__src_p__2F10007B]
    DEFAULT ((NULL)) FOR [src_prec_max]
GO

ALTER TABLE [dbo].[MSdbms_map] ADD CONSTRAINT [DF__MSdbms_ma__src_s__300424B4]
    DEFAULT ((NULL)) FOR [src_scale_min]
GO

ALTER TABLE [dbo].[MSdbms_map] ADD CONSTRAINT [DF__MSdbms_ma__src_s__30F848ED]
    DEFAULT ((NULL)) FOR [src_scale_max]
GO
