USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_smo_servers_stub] (
    [urn] nvarchar(512) NULL
    ,[powershell_path] nvarchar(4000) NULL
    ,[processing_time] datetimeoffset NULL
    ,[batch_time] datetimeoffset NULL
    ,[AuditLevel] smallint NULL
    ,[BackupDirectory] nvarchar(260) NULL
    ,[BrowserServiceAccount] nvarchar(128) NULL
    ,[BrowserStartMode] smallint NULL
    ,[BuildClrVersionString] nvarchar(20) NULL
    ,[BuildNumber] int NULL
    ,[Collation] nvarchar(128) NULL
    ,[CollationID] int NULL
    ,[ComparisonStyle] int NULL
    ,[ComputerNamePhysicalNetBIOS] nvarchar(128) NULL
    ,[DefaultFile] nvarchar(260) NULL
    ,[DefaultLog] nvarchar(260) NULL
    ,[Edition] nvarchar(64) NULL
    ,[EngineEdition] smallint NULL
    ,[ErrorLogPath] nvarchar(260) NULL
    ,[FilestreamShareName] nvarchar(260) NULL
    ,[InstallDataDirectory] nvarchar(260) NULL
    ,[InstallSharedDirectory] nvarchar(260) NULL
    ,[InstanceName] nvarchar(128) NULL
    ,[IsCaseSensitive] bit NULL
    ,[IsClustered] bit NULL
    ,[IsFullTextInstalled] bit NULL
    ,[IsSingleUser] bit NULL
    ,[Language] nvarchar(64) NULL
    ,[MailProfile] nvarchar(128) NULL
    ,[MasterDBLogPath] nvarchar(260) NULL
    ,[MasterDBPath] nvarchar(260) NULL
    ,[MaxPrecision] tinyint NULL
    ,[Name] nvarchar(128) NULL
    ,[NamedPipesEnabled] bit NULL
    ,[NetName] nvarchar(128) NULL
    ,[NumberOfLogFiles] int NULL
    ,[OSVersion] nvarchar(32) NULL
    ,[PerfMonMode] smallint NULL
    ,[PhysicalMemory] int NULL
    ,[Platform] nvarchar(32) NULL
    ,[Processors] smallint NULL
    ,[ProcessorUsage] int NULL
    ,[Product] nvarchar(48) NULL
    ,[ProductLevel] nvarchar(32) NULL
    ,[ResourceVersionString] nvarchar(32) NULL
    ,[RootDirectory] nvarchar(260) NULL
    ,[ServerType] smallint NULL
    ,[ServiceAccount] nvarchar(128) NULL
    ,[ServiceInstanceId] nvarchar(64) NULL
    ,[ServiceName] nvarchar(64) NULL
    ,[ServiceStartMode] smallint NULL
    ,[SqlCharSet] smallint NULL
    ,[SqlCharSetName] nvarchar(32) NULL
    ,[SqlDomainGroup] nvarchar(260) NULL
    ,[SqlSortOrder] smallint NULL
    ,[SqlSortOrderName] nvarchar(64) NULL
    ,[Status] smallint NULL
    ,[TapeLoadWaitTime] int NULL
    ,[TcpEnabled] bit NULL
    ,[VersionMajor] int NULL
    ,[VersionMinor] int NULL
    ,[VersionString] nvarchar(32) NULL
)
GO
