USE [msdb]
GO

CREATE TABLE [dbo].[sysdbmaintplans] (
    [plan_id] uniqueidentifier NOT NULL -- PK
    ,[plan_name] sysname NOT NULL
    ,[date_created] datetime NOT NULL -- DF [getdate()]
    ,[owner] sysname NOT NULL -- DF [isnull(nt_client(),suser_sname())]
    ,[max_history_rows] int NOT NULL -- DF [0]
    ,[remote_history_server] sysname NOT NULL -- DF ['']
    ,[max_remote_history_rows] int NOT NULL -- DF [0]
    ,[user_defined_1] int NULL
    ,[user_defined_2] nvarchar(100) NULL
    ,[user_defined_3] datetime NULL
    ,[user_defined_4] uniqueidentifier NULL

    ,CONSTRAINT [PK__sysdbmai__BE9F8F1DB6B34983]
        PRIMARY KEY ([plan_id])
)
GO

ALTER TABLE [dbo].[sysdbmaintplans] ADD CONSTRAINT [DF__sysdbmain__date___4460231C]
    DEFAULT ((getdate())) FOR [date_created]
GO

ALTER TABLE [dbo].[sysdbmaintplans] ADD CONSTRAINT [DF__sysdbmain__max_h__46486B8E]
    DEFAULT (((0))) FOR [max_history_rows]
GO

ALTER TABLE [dbo].[sysdbmaintplans] ADD CONSTRAINT [DF__sysdbmain__max_r__4830B400]
    DEFAULT (((0))) FOR [max_remote_history_rows]
GO

ALTER TABLE [dbo].[sysdbmaintplans] ADD CONSTRAINT [DF__sysdbmain__owner__45544755]
    DEFAULT ((isnull(nt_client(),suser_sname()))) FOR [owner]
GO

ALTER TABLE [dbo].[sysdbmaintplans] ADD CONSTRAINT [DF__sysdbmain__remot__473C8FC7]
    DEFAULT (('')) FOR [remote_history_server]
GO
