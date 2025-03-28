USE [master]
GO

CREATE TABLE [dbo].[spt_fallback_dev] (
    [xserver_name] varchar(30) NOT NULL
    ,[xdttm_ins] datetime NOT NULL
    ,[xdttm_last_ins_upd] datetime NOT NULL
    ,[xfallback_low] int NULL
    ,[xfallback_drive] char(2) NULL
    ,[low] int NOT NULL
    ,[high] int NOT NULL
    ,[status] smallint NOT NULL
    ,[name] varchar(30) NOT NULL
    ,[phyname] varchar(127) NOT NULL
)
GO

GRANT SELECT ON [spt_fallback_dev] TO [public]
GO
