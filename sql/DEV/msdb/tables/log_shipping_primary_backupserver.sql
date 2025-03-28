USE [msdb]
GO

CREATE TABLE [dbo].[log_shipping_primary_backupserver] (
    [primary_id] uniqueidentifier NOT NULL -- PK
    ,[server_with_port_override] sysname NULL

    ,CONSTRAINT [PK__log_ship__ED3BE1115CE78C63]
        PRIMARY KEY ([primary_id])
)
GO
