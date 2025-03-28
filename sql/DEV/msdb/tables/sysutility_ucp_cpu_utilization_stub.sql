USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_ucp_cpu_utilization_stub] (
    [processing_time] datetimeoffset NULL
    ,[aggregation_type] tinyint NOT NULL
    ,[object_type] tinyint NOT NULL
    ,[physical_server_name] sysname NOT NULL -- DF ['']
    ,[server_instance_name] sysname NOT NULL -- DF ['']
    ,[database_name] sysname NOT NULL -- DF ['']
    ,[percent_total_cpu_utilization] real NULL
)
GO

ALTER TABLE [dbo].[sysutility_ucp_cpu_utilization_stub] ADD CONSTRAINT [DF__sysutilit__datab__39B87777]
    DEFAULT (('')) FOR [database_name]
GO

ALTER TABLE [dbo].[sysutility_ucp_cpu_utilization_stub] ADD CONSTRAINT [DF__sysutilit__physi__37D02F05]
    DEFAULT (('')) FOR [physical_server_name]
GO

ALTER TABLE [dbo].[sysutility_ucp_cpu_utilization_stub] ADD CONSTRAINT [DF__sysutilit__serve__38C4533E]
    DEFAULT (('')) FOR [server_instance_name]
GO
