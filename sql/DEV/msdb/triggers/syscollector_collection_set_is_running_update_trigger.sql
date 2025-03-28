USE [msdb]
GO

CREATE   TRIGGER [dbo].[syscollector_collection_set_is_running_update_trigger] on [dbo].[syscollector_collection_sets_internal]
WITH EXECUTE AS OWNER -- 'MS_DataCollectorInternalUser'
FOR UPDATE
AS
BEGIN
    DECLARE @collection_set_id INT
    DECLARE @is_running BIT
    DECLARE @old_is_running BIT
    DECLARE @collection_mode SMALLINT

    IF (NOT UPDATE (is_running))
       RETURN

    DECLARE @collector_enabled int
    SET @collector_enabled = CONVERT(int, (SELECT parameter_value FROM dbo.syscollector_config_store_internal
                            WHERE parameter_name = 'CollectorEnabled'))
    IF @collector_enabled = 0
    BEGIN
        -- flipping the is_running bit has no effect when the collector is disabled
        RAISERROR(14682, 10, -1) -- severity 10 emits a warning
    END
    ELSE
    BEGIN
        DECLARE inserted_cursor CURSOR LOCAL FOR
            SELECT collection_set_id, is_running, collection_mode
            FROM inserted

        OPEN inserted_cursor
        FETCH inserted_cursor INTO @collection_set_id, @is_running, @collection_mode

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT @old_is_running = is_running FROM deleted WHERE collection_set_id = @collection_set_id

            -- If there is a change in the state, handle accordingly
            IF (@old_is_running <> @is_running)
            BEGIN
                IF (@is_running = 0)
                BEGIN
                    EXEC dbo.sp_syscollector_stop_collection_set_jobs @collection_set_id = @collection_set_id
                END
                ELSE IF (@is_running = 1)
                BEGIN
                    EXEC dbo.sp_syscollector_start_collection_set_jobs @collection_set_id = @collection_set_id
                END
            END

            FETCH inserted_cursor INTO @collection_set_id, @is_running, @collection_mode
        END

        CLOSE inserted_cursor
        DEALLOCATE inserted_cursor
    END
END
GO
