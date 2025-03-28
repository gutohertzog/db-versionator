USE [msdb]
GO

CREATE   TRIGGER [dbo].[syspolicy_execution_trigger] ON [dbo].[syspolicy_execution_internal]
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @retval_check int;
	EXECUTE @retval_check = [dbo].[sp_syspolicy_check_membership] 'PolicyAdministratorRole'
	IF ( 0!= @retval_check)
	BEGIN
		RETURN;
	END

	IF NOT EXISTS (SELECT * FROM inserted)
		RETURN

    DECLARE @policy_id int
    DECLARE @synchronous bit
    DECLARE @event_data xml
    DECLARE affected_policies CURSOR LOCAL FOR
        SELECT policy_id, synchronous, event_data FROM inserted

    OPEN affected_policies
    FETCH NEXT FROM affected_policies INTO @policy_id, @synchronous, @event_data
    DECLARE @err int
    SET @err = 0
    WHILE (@@FETCH_STATUS = 0 AND (@synchronous = 0 OR @err = 0))
    BEGIN
        DECLARE @pol_name sysname
        SELECT @pol_name = p.name
            FROM dbo.syspolicy_policies p
            WHERE p.policy_id = @policy_id

        IF (@synchronous = 0)
        BEGIN
            -- trace what policy is processing this event
            DECLARE @msg nvarchar(1000)
            SET @msg = N'Policy ''' + @pol_name + ''' was activated by an event.'
            RAISERROR(@msg, 1, 1) with log
        END

        -- execute the policy
        EXEC @err = msdb.sys.sp_syspolicy_execute_policy @policy_name =@pol_name, @event_data = @event_data, @synchronous = @synchronous

        -- move to the next policy if we're checking the policy
        -- or if we are in enforce mode and we haven't failed
        IF( @synchronous = 0 OR @err = 0)
            FETCH NEXT FROM affected_policies INTO @policy_id, @synchronous, @event_data
    END

    CLOSE affected_policies
    DEALLOCATE affected_policies

END
GO
