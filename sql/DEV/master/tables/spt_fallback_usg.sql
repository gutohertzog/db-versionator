USE [master]
GO

CREATE TABLE [dbo].[spt_fallback_usg] (
    [xserver_name] varchar(30) NOT NULL
    ,[xdttm_ins] datetime NOT NULL
    ,[xdttm_last_ins_upd] datetime NOT NULL
    ,[xfallback_vstart] int NULL
    ,[dbid] smallint NOT NULL
    ,[segmap] int NOT NULL
    ,[lstart] int NOT NULL
    ,[sizepg] int NOT NULL
    ,[vstart] int NOT NULL
)
GO

GRANT SELECT ON [spt_fallback_usg] TO [public]
GO
