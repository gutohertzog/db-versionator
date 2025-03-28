USE [msdb]
GO

CREATE TABLE [dbo].[suspect_pages] (
    [database_id] int NOT NULL
    ,[file_id] int NOT NULL
    ,[page_id] bigint NOT NULL
    ,[event_type] int NOT NULL
    ,[error_count] int NOT NULL
    ,[last_update_date] datetime NOT NULL -- DF [getdate()]
)
GO

ALTER TABLE [dbo].[suspect_pages] ADD CONSTRAINT [DF__suspect_p__last___76EBA2E9]
    DEFAULT ((getdate())) FOR [last_update_date]
GO

GRANT SELECT ON [suspect_pages] TO [public]
GO
