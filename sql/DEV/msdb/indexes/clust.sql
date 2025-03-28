USE [msdb]
GO

CREATE CLUSTERED INDEX [clust] ON [dbo].[sysdbmaintplan_history]
(
    [plan_id],
    [job_id],
    [job_id]
)
GO
