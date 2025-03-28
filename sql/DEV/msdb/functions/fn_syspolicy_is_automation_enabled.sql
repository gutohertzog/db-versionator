USE [msdb]
GO

CREATE   FUNCTION fn_syspolicy_is_automation_enabled()
RETURNS bit
AS
BEGIN
    DECLARE @ret bit;
    SELECT @ret = CONVERT(bit, current_value)
        FROM msdb.dbo.syspolicy_configuration
        WHERE name = 'Enabled'

    RETURN @ret;
END
GO

GRANT EXECUTE ON [fn_syspolicy_is_automation_enabled] TO [public]
GO
