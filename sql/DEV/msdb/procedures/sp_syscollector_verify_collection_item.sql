USE [msdb]
GO

CREATE   PROCEDURE [dbo].[sp_syscollector_verify_collection_item]
    @collection_item_id        int = NULL OUTPUT,
    @name                    sysname = NULL OUTPUT
AS
BEGIN
    IF (@name IS NOT NULL)
    BEGIN
        -- Remove any leading/trailing spaces from parameters
        SET @name                    = NULLIF(LTRIM(RTRIM(@name)), N'')
    END

    IF (@collection_item_id IS NULL AND @name IS NULL)
    BEGIN
        RAISERROR(14624, -1, -1, '@collection_item_id, @name')
        RETURN(1)
    END

    IF (@collection_item_id IS NOT NULL AND @name IS NOT NULL)
    BEGIN
        IF (NOT EXISTS(SELECT *
                        FROM dbo.syscollector_collection_items
                        WHERE collection_item_id = @collection_item_id
                        AND name = @name))
        BEGIN
            DECLARE @errMsg NVARCHAR(196)
            SELECT @errMsg = CONVERT(NVARCHAR(36), @collection_item_id) + ', ' + @name
            RAISERROR(14262, -1, -1, '@collection_item_id, @name', @errMsg)
            RETURN(1)
        END
    END
    -- Check id
    ELSE IF (@collection_item_id IS NOT NULL)
    BEGIN
        SELECT @name = name
        FROM dbo.syscollector_collection_items
        WHERE (collection_item_id = @collection_item_id)

        -- the view would take care of all the permissions issues.
        IF (@name IS NULL)
        BEGIN
            DECLARE @collection_item_id_as_char VARCHAR(36)
            SELECT @collection_item_id_as_char = CONVERT(VARCHAR(36), @collection_item_id)
            RAISERROR(14262, -1, -1, '@collection_item_id', @collection_item_id_as_char)
            RETURN(1) -- Failure
        END
    END
    -- Check name
    ELSE IF (@name IS NOT NULL)
    BEGIN
        -- get the corresponding collection_item_id (if the collection_item exists)
        SELECT @collection_item_id = collection_item_id
        FROM dbo.syscollector_collection_items
        WHERE (name = @name)

        -- the view would take care of all the permissions issues.
        IF (@collection_item_id IS NULL)
        BEGIN
            RAISERROR(14262, -1, -1, '@name', @name)
            RETURN(1) -- Failure
        END
    END
    RETURN (0)
END
GO
