USE [AdventureWorks2022]
GO

CREATE TABLE [HumanResources].[Shift] (
    [ShiftID] tinyint NOT NULL IDENTITY(1,1) -- PK
    ,[Name] Name NOT NULL
    ,[StartTime] time NOT NULL
    ,[EndTime] time NOT NULL
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_Shift_ShiftID]
        PRIMARY KEY ([ShiftID])
)
GO

ALTER TABLE [HumanResources].[Shift] ADD CONSTRAINT [DF_Shift_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
