USE [msdb]
GO

CREATE   PROCEDURE dbo.sp_sysdac_ensure_dac_creator
as
BEGIN
    -- only users that can create a dac can add parts
    IF (dbo.fn_sysdac_is_dac_creator() != 1)
    BEGIN
        RAISERROR(36010, -1, -1);
        RETURN(1); -- failure
    END
END
GO

GRANT EXECUTE ON [sp_sysdac_ensure_dac_creator] TO [public]
GO
