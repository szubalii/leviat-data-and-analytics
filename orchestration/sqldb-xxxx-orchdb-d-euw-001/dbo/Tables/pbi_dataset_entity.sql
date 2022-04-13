CREATE TABLE [dbo].[pbi_dataset_entity]
(
    [pbi_dataset_id]		BIGINT NOT NULL,
    [dataset_name]          NVARCHAR(68),
    [entity_id]				BIGINT NOT NULL,
    [entity_name]           NVARCHAR(68),

    PRIMARY KEY CLUSTERED ([pbi_dataset_id], [entity_id]),
    CONSTRAINT [FK_pbi_dataset_entity__pbi_dataset] FOREIGN KEY ([pbi_dataset_id]) REFERENCES [dbo].[pbi_dataset] ([pbi_dataset_id]),
    CONSTRAINT [FK_pbi_dataset_entity__entity] FOREIGN KEY ([entity_id]) REFERENCES [dbo].[entity] ([entity_id])
);