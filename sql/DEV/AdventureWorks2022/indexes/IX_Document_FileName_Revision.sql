USE [AdventureWorks2022]
GO

CREATE NONCLUSTERED INDEX [IX_Document_FileName_Revision] ON [Production].[Document]
(
    [FileName],
    [Revision]
)
GO
