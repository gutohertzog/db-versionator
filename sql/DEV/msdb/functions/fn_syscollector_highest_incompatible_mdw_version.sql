USE [msdb]
GO

CREATE   FUNCTION [dbo].[fn_syscollector_highest_incompatible_mdw_version]()
RETURNS nvarchar(50)
BEGIN
    RETURN '10.00.1300.13'  -- CTP6
END
GO

GRANT EXECUTE ON [fn_syscollector_highest_incompatible_mdw_version] TO [dc_admin]
GRANT EXECUTE ON [fn_syscollector_highest_incompatible_mdw_version] TO [dc_proxy]
GO
