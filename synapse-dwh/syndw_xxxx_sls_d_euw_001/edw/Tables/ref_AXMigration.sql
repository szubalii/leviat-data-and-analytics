CREATE TABLE [edw].[ref_AXMigration]
(
    [StorageLocationID]               nvarchar(10),
    [MigrationDate]                   date,
    CONSTRAINT [PK_ref_AXMigration] PRIMARY KEY NONCLUSTERED (
        [StorageLocationID]
    ) NOT ENFORCED
)
WITH ( DISTRIBUTION = HASH ([StorageLocationID]), CLUSTERED COLUMNSTORE INDEX )