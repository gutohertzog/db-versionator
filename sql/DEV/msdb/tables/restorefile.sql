USE [msdb]
GO

CREATE TABLE [dbo].[restorefile] (
    [restore_history_id] int NOT NULL -- FK [restorehistory]
    ,[file_number] numeric(10, 0) NULL
    ,[destination_phys_drive] nvarchar(260) NULL
    ,[destination_phys_name] nvarchar(260) NULL

    ,CONSTRAINT [FK__restorefi__resto__7132C993]
        FOREIGN KEY ([restore_history_id])
        REFERENCES [dbo].[restorehistory] ([restore_history_id])
)
GO

GRANT SELECT ON [restorefile] TO [public]
GO
