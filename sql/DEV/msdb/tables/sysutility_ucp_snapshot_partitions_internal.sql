USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_snapshot_partitions_internal] (
    [time_id] int NULL
    ,[latest_consistent_snapshot_id] int NULL
)
GO
