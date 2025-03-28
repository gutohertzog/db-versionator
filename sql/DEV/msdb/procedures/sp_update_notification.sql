USE [msdb]
GO

CREATE   PROCEDURE sp_update_notification
  @alert_name          sysname,
  @operator_name       sysname,
  @notification_method TINYINT -- 1 = Email, 2 = Pager, 4 = NetSend, 7 = All
AS
BEGIN
  DECLARE @alert_id             INT
  DECLARE @operator_id          INT
  DECLARE @notification         NVARCHAR(512)
  DECLARE @retval               INT
  DECLARE @old_has_notification INT
  DECLARE @new_has_notification INT
  DECLARE @res_notification     NVARCHAR(100)

  SET NOCOUNT ON

  -- If this is Azure SQL Database - Managed Instance throw an exception for unsupported option
  IF ((@notification_method & 4 = 4) AND SERVERPROPERTY('EngineEdition') = 8)
  BEGIN
    RAISERROR(41914, -1, 16, 'NetSend')
    RETURN(1) -- Failure
  END

  SELECT @res_notification = FORMATMESSAGE(14210)

  -- Remove any leading/trailing spaces from parameters
  SELECT @alert_name    = LTRIM(RTRIM(@alert_name))
  SELECT @operator_name = LTRIM(RTRIM(@operator_name))

  -- Only a sysadmin can do this
  IF ((ISNULL(IS_SRVROLEMEMBER(N'sysadmin'), 0) <> 1))
  BEGIN
    RAISERROR(15003, 16, 1, N'sysadmin')
    RETURN(1) -- Failure
  END

  -- Check if the Notification is valid
  EXECUTE sp_verify_notification @alert_name,
                                 @operator_name,
                                 @notification_method,
                                 @alert_id     OUTPUT,
                                 @operator_id  OUTPUT

  -- Check if this notification exists
  IF (NOT EXISTS (SELECT *
                  FROM msdb.dbo.sysnotifications
                  WHERE (alert_id = @alert_id)
                    AND (operator_id = @operator_id)))
  BEGIN
    SELECT @notification = @alert_name + N' / ' + @operator_name
    RAISERROR(14262, 16, 1, @res_notification, @notification)
    RETURN(1) -- Failure
  END

  SELECT @old_has_notification = has_notification
  FROM msdb.dbo.sysalerts
  WHERE (id = @alert_id)

  -- Do the UPDATE
  UPDATE msdb.dbo.sysnotifications
  SET notification_method = @notification_method
  WHERE (alert_id = @alert_id)
    AND (operator_id = @operator_id)

  SELECT @retval = @@error

  SELECT @new_has_notification = has_notification
  FROM msdb.dbo.sysalerts
  WHERE (id = @alert_id)

  -- Notify SQLServerAgent of the change - if any - to has_notifications
  IF (@old_has_notification <> @new_has_notification)
    EXECUTE msdb.dbo.sp_sqlagent_notify @op_type       = N'A',
                                          @alert_id    = @alert_id,
                                          @action_type = N'U'

  RETURN(@retval) -- 0 means success
END
GO
