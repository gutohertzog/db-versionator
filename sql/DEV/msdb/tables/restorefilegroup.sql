USE [msdb]
GO

CREATE TABLE [dbo].[restorefilegroup] (
    [restore_history_id] int NOT NULL -- FK [restorehistory]
    ,[filegroup_name] nvarchar(128) NULL

    ,CONSTRAINT [FK__restorefi__resto__731B1205]
        FOREIGN KEY ([restore_history_id])
        REFERENCES [dbo].[restorehistory] ([restore_history_id])
)
GO

GRANT SELECT ON [restorefilegroup] TO [public]
GO
