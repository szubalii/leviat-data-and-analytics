CREATE TABLE [log].[pbi_dataset_entity]
(
    [ExistingPbi_dataset_id] BIGINT,
    [ExistingDataset_name] NVARCHAR(68),
    [ExistingEntity_id] BIGINT,
    [ExistingEntity_name] NVARCHAR(68),
    ActionTaken NVARCHAR(10),
    [NewPbi_dataset_id] BIGINT,
    [NewDataset_name] NVARCHAR(68),
    [NewEntity_id] BIGINT,
    [NewEntity_name] NVARCHAR(68),
    t_jobDtm DATETIME
)
