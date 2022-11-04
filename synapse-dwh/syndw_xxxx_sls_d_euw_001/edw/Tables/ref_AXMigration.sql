CREATE TABLE [edw].[ref_AXMigration]
(
    [StorageLocationID]               nvarchar(10) collate,
    [MigrationDate]                   date
)
WITH ( DISTRIBUTION = HASH ([StorageLocationID]), CLUSTERED COLUMNSTORE INDEX )