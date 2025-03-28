USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_Address_StateProvinceID] ON [Person].[Address]
(
    [StateProvinceID]
)
GO
