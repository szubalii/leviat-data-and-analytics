CREATE TABLE [edw].[ref_AXMigration]
(
    [DATAAREAID]               nvarchar(4),
    [MigrationDate]                   date,
    CONSTRAINT [PK_ref_AXMigration] PRIMARY KEY NONCLUSTERED (
        [DATAAREAID]
    ) NOT ENFORCED
)
WITH ( DISTRIBUTION = HASH ([DATAAREAID]), CLUSTERED COLUMNSTORE INDEX )