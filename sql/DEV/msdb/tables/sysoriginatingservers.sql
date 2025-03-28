USE [msdb]
GO

CREATE TABLE [dbo].[sysoriginatingservers] (
    [originating_server_id] int NULL -- UK DF [1] CK [= 1 ]
    ,[originating_server] sysname NOT NULL -- UK
    ,[master_server] bit NULL -- DF [1] CK [= 1 ]

    ,CONSTRAINT [UQ__sysorigi__57F15AACD8F6AF25]
        UNIQUE CLUSTERED ([originating_server], [originating_server])

    ,CONSTRAINT [UQ__sysorigi__D65E569CE9484536]
        UNIQUE CLUSTERED ([originating_server_id], [originating_server_id])

    ,CONSTRAINT [CK_master_server_MustBe_1]
        CHECK (([master_server]=(1)))

    ,CONSTRAINT [CK_originating_server_id_MustBe_1]
        CHECK (([originating_server_id]=(1)))
)
GO

ALTER TABLE [dbo].[sysoriginatingservers] ADD CONSTRAINT [DF__sysorigin__maste__5BE2A6F2]
    DEFAULT (((1))) FOR [master_server]
GO

ALTER TABLE [dbo].[sysoriginatingservers] ADD CONSTRAINT [DF__sysorigin__origi__59FA5E80]
    DEFAULT (((1))) FOR [originating_server_id]
GO
