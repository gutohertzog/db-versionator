USE [msdb]
GO

CREATE   TRIGGER [dbo].[syscollector_collection_item_parameter_update_trigger] on [dbo].[syscollector_collection_items_internal]
FOR UPDATE
AS
BEGIN
    DECLARE @collection_set_id int
    DECLARE @collection_item_id int

    -- remove the TSQL query collection item that was updated so packages will be regenerated
    -- base on the new parameters
    IF (NOT UPDATE (parameters))
       RETURN

    -- clean up the SSIS packages that are left behind
    DECLARE inserted_cursor CURSOR LOCAL FOR
        SELECT collection_set_id, collection_item_id
        FROM inserted

    OPEN inserted_cursor
    FETCH inserted_cursor INTO @collection_set_id, @collection_item_id

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DELETE FROM dbo.syscollector_tsql_query_collector
        WHERE collection_set_id = @collection_set_id
        AND collection_item_id = @collection_item_id

        FETCH inserted_cursor INTO @collection_set_id, @collection_item_id
    END

    CLOSE inserted_cursor
    DEALLOCATE inserted_cursor
END
GO
