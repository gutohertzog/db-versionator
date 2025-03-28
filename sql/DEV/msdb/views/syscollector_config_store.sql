USE [msdb]
GO

CREATE   VIEW [dbo].[syscollector_config_store]
AS
    SELECT
        s.parameter_name,
        s.parameter_value
    FROM
        [dbo].[syscollector_config_store_internal] s
GO

GRANT SELECT ON [syscollector_config_store] TO [dc_operator]
GRANT SELECT ON [syscollector_config_store] TO [dc_proxy]
GO
