CREATE TABLE [base_s4h_cax].[I_InventoryTransactionType]
(
    [InventoryTransactionType]    nvarchar(2) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [IsPhysicalInventoryRelevant] nvarchar(1) -- collate Latin1_General_100_BIN2,
    [IsMaterialDocumentRelevant]  nvarchar(1) -- collate Latin1_General_100_BIN2,
    [IsReservationRelevant]       nvarchar(1) -- collate Latin1_General_100_BIN2,
    [t_applicationId]             VARCHAR(32),
    [t_jobId]                     VARCHAR(36),
    [t_jobDtm]                    DATETIME,
    [t_jobBy]                     NVARCHAR(128),
    [t_extractionDtm]             DATETIME,
    [t_filePath]                  NVARCHAR(1024),
    CONSTRAINT [PK_I_InventoryTransactionType] PRIMARY KEY NONCLUSTERED (
        [InventoryTransactionType]
    ) NOT ENFORCED
)
WITH (
    HEAP
    )