USE [master]
GO

create procedure dbo.sp_MSrepl_startup
as
    exec sys.sp_MSrepl_startup_internal
GO
