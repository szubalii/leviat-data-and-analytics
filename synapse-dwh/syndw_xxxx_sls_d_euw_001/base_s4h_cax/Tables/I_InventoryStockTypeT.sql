CREATE TABLE [base_s4h_cax].[I_InventoryStockTypeT]
(
    [InventoryStockType]     NVARCHAR(2) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [Language]               NCHAR(1) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [InventoryStockTypeName] NVARCHAR(60), -- collate Latin1_General_100_BIN2,
    [t_applicationId]        VARCHAR (32),
    [t_jobId]                VARCHAR(36),
    [t_jobDtm]               DATETIME,
    [t_jobBy]                NVARCHAR(128),
    [t_extractionDtm]        DATETIME,
    [t_filePath]             NVARCHAR(1024)
, CONSTRAINT [PK_I_InventoryStockTypeT] PRIMARY KEY NONCLUSTERED (
    [InventoryStockType], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
