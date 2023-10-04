CREATE TABLE [base_s4h_cax].[I_GoodsMovementType]
(
    [MANDT]                  char(3) collate Latin1_General_100_BIN2     NOT NULL,
    [GoodsMovementType]      nvarchar(3) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [IsReversalMovementType] nvarchar(1), -- collate Latin1_General_100_BIN2,
    [t_applicationId]        VARCHAR(32),
    [t_jobId]                VARCHAR(36),
    [t_jobDtm]               DATETIME,
    [t_jobBy]                NVARCHAR(128),
    [t_extractionDtm]        DATETIME,
    [t_filePath]             NVARCHAR(1024)
, CONSTRAINT [PK_I_GoodsMovementType] PRIMARY KEY NONCLUSTERED (
    [MANDT], [GoodsMovementType]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
