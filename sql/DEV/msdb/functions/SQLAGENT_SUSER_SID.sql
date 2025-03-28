USE [msdb]
GO

CREATE   FUNCTION dbo.SQLAGENT_SUSER_SID(@user_name sysname) RETURNS VARBINARY(85)
AS
BEGIN
  DECLARE @ret VARBINARY(85)
  IF @user_name = N'$(SQLAgentAccount)'
    SELECT @ret = 0xFFFFFFFF
  ELSE
    SELECT @ret = SUSER_SID(@user_name, 0)
  RETURN @ret
END
GO
