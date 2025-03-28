USE [msdb]
GO

CREATE   PROCEDURE sp_delete_targetsvrgrp_member
  @group_name  sysname,
  @server_name sysname
AS
BEGIN
  DECLARE @servergroup_id INT
  DECLARE @server_id      INT

  SET NOCOUNT ON

  -- Remove any leading/trailing spaces from parameters
  SELECT @group_name = LTRIM(RTRIM(@group_name))
  SELECT @server_name = UPPER(LTRIM(RTRIM(@server_name)))

  -- Check if the group exists
  SELECT @servergroup_id = servergroup_id
  FROM msdb.dbo.systargetservergroups
  WHERE (name = @group_name)

  IF (@servergroup_id IS NULL)
  BEGIN
    RAISERROR(14262, -1, -1, '@group_name', @group_name)
    RETURN(1) -- Failure
  END

  -- Check if the server exists
  SELECT @server_id = server_id
  FROM msdb.dbo.systargetservers
  WHERE (UPPER(server_name) = @server_name)

  IF (@server_id IS NULL)
  BEGIN
    RAISERROR(14262, -1, -1, '@server_name', @server_name)
    RETURN(1) -- Failure
  END

  -- Check if the server is in the group
  IF (NOT EXISTS (SELECT *
                  FROM msdb.dbo.systargetservergroupmembers
                  WHERE (servergroup_id = @servergroup_id)
                    AND (server_id = @server_id)))
  BEGIN
    RAISERROR(14264, -1, -1, @server_name, @group_name)
    RETURN(1) -- Failure
  END

  -- Delete the row from systargetservergroupmembers
  DELETE FROM msdb.dbo.systargetservergroupmembers
  WHERE (servergroup_id = @servergroup_id)
    AND (server_id = @server_id)

  RETURN(@@error) -- 0 means success
END
GO
