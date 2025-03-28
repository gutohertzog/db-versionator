USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_BillOfMaterials_UnitMeasureCode] ON [Production].[BillOfMaterials]
(
    [UnitMeasureCode]
)
GO
