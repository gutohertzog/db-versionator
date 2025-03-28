USE [AdventureWorks2022]
GO

CREATE TABLE [Production].[WorkOrderRouting] (
    [WorkOrderID] int NOT NULL -- PK FK [WorkOrder]
    ,[ProductID] int NOT NULL -- PK
    ,[OperationSequence] smallint NOT NULL -- PK
    ,[LocationID] smallint NOT NULL -- FK [Location]
    ,[ScheduledStartDate] datetime NOT NULL
    ,[ScheduledEndDate] datetime NOT NULL
    ,[ActualStartDate] datetime NULL
    ,[ActualEndDate] datetime NULL
    ,[ActualResourceHrs] decimal(9, 4) NULL -- CK [>= 0.0000 ]
    ,[PlannedCost] money NOT NULL -- CK [> 0.00 ]
    ,[ActualCost] money NULL -- CK [> 0.00 ]
    ,[ModifiedDate] datetime NOT NULL -- DF [getdate()]

    ,CONSTRAINT [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence]
        PRIMARY KEY ([WorkOrderID], [ProductID], [OperationSequence])

    ,CONSTRAINT [FK_WorkOrderRouting_Location_LocationID]
        FOREIGN KEY ([LocationID])
        REFERENCES [Production].[Location] ([LocationID])

    ,CONSTRAINT [FK_WorkOrderRouting_WorkOrder_WorkOrderID]
        FOREIGN KEY ([WorkOrderID])
        REFERENCES [Production].[WorkOrder] ([WorkOrderID])

    ,CONSTRAINT [CK_WorkOrderRouting_ActualCost]
        CHECK (([ActualCost]>(0.00)))

    ,CONSTRAINT [CK_WorkOrderRouting_ActualResourceHrs]
        CHECK (([ActualResourceHrs]>=(0.0000)))

    ,CONSTRAINT [CK_WorkOrderRouting_PlannedCost]
        CHECK (([PlannedCost]>(0.00)))
)
GO

ALTER TABLE [Production].[WorkOrderRouting] ADD CONSTRAINT [DF_WorkOrderRouting_ModifiedDate]
    DEFAULT ((getdate())) FOR [ModifiedDate]
GO
