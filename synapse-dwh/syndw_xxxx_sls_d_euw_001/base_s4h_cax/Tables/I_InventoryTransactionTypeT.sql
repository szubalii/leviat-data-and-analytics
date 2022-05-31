CREATE TABLE [base_s4h_cax].[I_InventoryTransactionTypeT]
(
    [MANDT]                        char(3) collate Latin1_General_100_BIN2  NOT NULL,
    [InventoryTransactionType]     nvarchar (2) collate Latin1_General_100_BIN2 NOT NULL,
    [Language]                     nchar(1) collate Latin1_General_100_BIN2 NOT NULL,
    [InventoryTransactionTypeText] nvarchar(40) collate Latin1_General_100_BIN2,
    [t_applicationId]              VARCHAR(32),
    [t_jobId]                      VARCHAR(36),
    [t_jobDtm]                     DATETIME,
    [t_jobBy]                      NVARCHAR(128),
    [t_extractionDtm]              DATETIME,
    [t_filePath]                   NVARCHAR(1024), 
    CONSTRAINT [PK_I_InventoryTransactionTypeT] PRIMARY KEY NONCLUSTERED (
    [MANDT], [InventoryTransactionType], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
