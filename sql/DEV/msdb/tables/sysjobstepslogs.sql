USE [msdb]
GO

CREATE TABLE [dbo].[sysjobstepslogs] (
    [log_id] int NOT NULL IDENTITY(1,1) -- PK
    ,[log] nvarchar(MAX) NOT NULL
    ,[date_created] datetime NOT NULL -- DF [getdate()]
    ,[date_modified] datetime NOT NULL -- DF [getdate()]
    ,[log_size] bigint NULL
    ,[step_uid] uniqueidentifier NOT NULL -- FK [sysjobsteps]

    ,CONSTRAINT [PK__sysjobst__9E2397E0A9614B96]
        PRIMARY KEY ([log_id])

    ,CONSTRAINT [FK__sysjobste__step___6C190EBB]
        FOREIGN KEY ([step_uid])
        REFERENCES [dbo].[sysjobsteps] ([step_uid])
)
GO

ALTER TABLE [dbo].[sysjobstepslogs] ADD CONSTRAINT [DF__sysjobste__date___6A30C649]
    DEFAULT ((getdate())) FOR [date_created]
GO

ALTER TABLE [dbo].[sysjobstepslogs] ADD CONSTRAINT [DF__sysjobste__date___6B24EA82]
    DEFAULT ((getdate())) FOR [date_modified]
GO
