USE [master]
GO

CREATE TABLE [dbo].[spt_fallback_db] (
    [xserver_name] varchar(30) NOT NULL
    ,[xdttm_ins] datetime NOT NULL
    ,[xdttm_last_ins_upd] datetime NOT NULL
    ,[xfallback_dbid] smallint NULL
    ,[name] varchar(30) NOT NULL
    ,[dbid] smallint NOT NULL
    ,[status] smallint NOT NULL
    ,[version] smallint NOT NULL
)
GO

GRANT SELECT ON [spt_fallback_db] TO [public]
GO
