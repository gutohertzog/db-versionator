USE [master]
GO

create procedure dbo.sp_MScleanupmergepublisher
as
    exec sys.sp_MScleanupmergepublisher_internal
GO
