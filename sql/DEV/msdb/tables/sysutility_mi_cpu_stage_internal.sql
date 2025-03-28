USE [msdb]
GO

CREATE TABLE [dbo].[sysutility_mi_cpu_stage_internal] (
    [num_processors] int NOT NULL -- DF [-1]
    ,[cpu_name] nvarchar(128) NOT NULL -- DF [N'']
    ,[cpu_caption] nvarchar(128) NOT NULL -- DF [N'']
    ,[cpu_family_id] decimal(5, 0) NOT NULL -- DF [-1]
    ,[cpu_architecture_id] decimal(5, 0) NOT NULL -- DF [-1]
    ,[cpu_max_clock_speed] decimal(10, 0) NOT NULL -- DF [0.0]
    ,[cpu_clock_speed] decimal(10, 0) NOT NULL -- DF [0.0]
    ,[l2_cache_size] decimal(10, 0) NOT NULL -- DF [0.0]
    ,[l3_cache_size] decimal(10, 0) NOT NULL -- DF [0.0]
    ,[instance_processor_usage_start_ticks] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[instance_collect_time_start_ticks] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[computer_processor_idle_start_ticks] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[computer_collect_time_start_ticks] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[instance_processor_usage_end_ticks] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[instance_collect_time_end_ticks] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[computer_processor_idle_end_ticks] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[computer_collect_time_end_ticks] decimal(20, 0) NOT NULL -- DF [0.0]
    ,[server_instance_name] sysname NULL
    ,[virtual_server_name] sysname NULL
    ,[physical_server_name] sysname NULL
    ,[instance_processor_usage_percentage] real NULL
    ,[computer_processor_usage_percentage] real NULL
)
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__compu__15C52FC4]
    DEFAULT (((0.0))) FOR [computer_processor_idle_start_ticks]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__compu__16B953FD]
    DEFAULT (((0.0))) FOR [computer_collect_time_start_ticks]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__compu__1995C0A8]
    DEFAULT (((0.0))) FOR [computer_processor_idle_end_ticks]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__compu__1A89E4E1]
    DEFAULT (((0.0))) FOR [computer_collect_time_end_ticks]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__cpu_a__0F183235]
    DEFAULT (((-1))) FOR [cpu_architecture_id]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__cpu_c__0D2FE9C3]
    DEFAULT ((N'')) FOR [cpu_caption]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__cpu_c__11007AA7]
    DEFAULT (((0.0))) FOR [cpu_clock_speed]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__cpu_f__0E240DFC]
    DEFAULT (((-1))) FOR [cpu_family_id]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__cpu_m__100C566E]
    DEFAULT (((0.0))) FOR [cpu_max_clock_speed]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__cpu_n__0C3BC58A]
    DEFAULT ((N'')) FOR [cpu_name]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__insta__13DCE752]
    DEFAULT (((0.0))) FOR [instance_processor_usage_start_ticks]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__insta__14D10B8B]
    DEFAULT (((0.0))) FOR [instance_collect_time_start_ticks]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__insta__17AD7836]
    DEFAULT (((0.0))) FOR [instance_processor_usage_end_ticks]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__insta__18A19C6F]
    DEFAULT (((0.0))) FOR [instance_collect_time_end_ticks]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__l2_ca__11F49EE0]
    DEFAULT (((0.0))) FOR [l2_cache_size]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__l3_ca__12E8C319]
    DEFAULT (((0.0))) FOR [l3_cache_size]
GO

ALTER TABLE [dbo].[sysutility_mi_cpu_stage_internal] ADD CONSTRAINT [DF__sysutilit__num_p__0B47A151]
    DEFAULT (((-1))) FOR [num_processors]
GO

GRANT SELECT ON [sysutility_mi_cpu_stage_internal] TO [UtilityIMRReader]
GRANT DELETE, INSERT ON [sysutility_mi_cpu_stage_internal] TO [UtilityIMRWriter]
GO
