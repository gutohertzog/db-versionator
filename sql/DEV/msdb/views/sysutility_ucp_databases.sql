USE [msdb]
GO

CREATE   VIEW dbo.sysutility_ucp_databases
AS
   SELECT	S.urn
        , S.parent_urn
        , S.Collation
        , S.CompatibilityLevel
        , S.CreateDate
        , S.EncryptionEnabled
        , S.Name
        , S.server_instance_name
        , S.powershell_path
        , S.RecoveryModel
        , [S].[Trustworthy]
        , [S].processing_time
        , S.state
      FROM [dbo].[syn_sysutility_ucp_databases] AS S
GO

GRANT SELECT ON [sysutility_ucp_databases] TO [UtilityCMRReader]
GO
