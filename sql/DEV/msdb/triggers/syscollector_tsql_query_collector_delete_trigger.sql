USE [msdb]
GO

CREATE   TRIGGER [dbo].[syscollector_tsql_query_collector_delete_trigger] on [dbo].[syscollector_tsql_query_collector]
FOR DELETE
AS
BEGIN
    -- remove the SSIS packages left behind when the collection item is deleted
    DECLARE @collection_package_id uniqueidentifier
    DECLARE @collection_package_folderid uniqueidentifier
    DECLARE @collection_package_name sysname

    DECLARE @upload_package_id  uniqueidentifier
    DECLARE @upload_package_folderid  uniqueidentifier
    DECLARE @upload_package_name  sysname

    DECLARE deleted_cursor CURSOR LOCAL FOR
        SELECT collection_package_id, upload_package_id
        FROM deleted

    OPEN deleted_cursor
    FETCH deleted_cursor INTO @collection_package_id, @upload_package_id

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT
            @collection_package_name = name,
            @collection_package_folderid = folderid
        FROM sysssispackages
        WHERE @collection_package_id = id

        SELECT
            @upload_package_name = name,
            @upload_package_folderid = folderid
        FROM sysssispackages
        WHERE @upload_package_id = id

        EXEC dbo.sp_ssis_deletepackage
            @name = @collection_package_name,
            @folderid = @collection_package_folderid

        EXEC dbo.sp_ssis_deletepackage
            @name = @upload_package_name,
            @folderid = @upload_package_folderid

        FETCH deleted_cursor INTO @collection_package_id, @upload_package_id
    END

    CLOSE deleted_cursor
    DEALLOCATE deleted_cursor
END
GO
