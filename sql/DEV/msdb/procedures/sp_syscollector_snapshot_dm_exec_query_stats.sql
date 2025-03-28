USE [msdb]
GO

CREATE   PROC [dbo].[sp_syscollector_snapshot_dm_exec_query_stats]
  @collection_item_id         int
AS
BEGIN
    DECLARE @include_system_databases bit = 1

    DECLARE @returnValue int = 1
    EXEC @returnValue = [dbo].[sp_syscollector_get_query_activity_collection_item_params] @collection_item_id, @include_system_databases OUTPUT

    IF(@returnValue <> 1 )
    BEGIN
        EXEC [dbo].[sp_syscollector_snapshot_dm_exec_query_stats_internal]  @include_system_databases
    END
END
GO

GRANT EXECUTE ON [sp_syscollector_snapshot_dm_exec_query_stats] TO [dc_proxy]
GO
