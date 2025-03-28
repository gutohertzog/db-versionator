USE [msdb]
GO

CREATE   FUNCTION fn_autoadmin_min_schema_version()
RETURNS INT
AS
BEGIN
    -- schema version 1 is minimum supported version
    RETURN 1
END
GO
