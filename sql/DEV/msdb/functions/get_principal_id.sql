USE [msdb]
GO

-----------------------------------------------------------
-- get_principal_id : retrieves principal_id for a given sid
--
-----------------------------------------------------------
CREATE   FUNCTION dbo.get_principal_id(@principal_sid varbinary(85))
RETURNS int
AS
BEGIN
    DECLARE @principal_id int
    SELECT @principal_id=principal_id FROM msdb.sys.database_principals WHERE sid=@principal_sid
    RETURN @principal_id
END
GO
