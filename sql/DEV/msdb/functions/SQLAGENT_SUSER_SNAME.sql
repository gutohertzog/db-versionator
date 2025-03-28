USE [msdb]
GO

CREATE   FUNCTION dbo.SQLAGENT_SUSER_SNAME(@user_sid VARBINARY(85)) RETURNS sysname
AS
BEGIN
  DECLARE @ret sysname
  IF @user_sid = 0xFFFFFFFF
    SELECT @ret = N'$(SQLAgentAccount)'
  ELSE
    SELECT @ret = SUSER_SNAME(@user_sid)
  RETURN @ret
END
GO
