CREATE TABLE [base_s4h_cax].[I_InventoryValuationType]
(
    [MANDT]                  char(3) collate Latin1_General_100_BIN2      NOT NULL,
    [InventoryValuationType] nvarchar(10) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [AcctCategoryRef]        nvarchar(4), -- collate Latin1_General_100_BIN2,
    [InternalPurchasingRule] nvarchar(1), -- collate Latin1_General_100_BIN2,
    [ExternalPurchasingRule] nvarchar(1), -- collate Latin1_General_100_BIN2,
    [t_applicationId]        VARCHAR (32),
    [t_jobId]                VARCHAR (36),
    [t_jobDtm]               DATETIME,
    [t_jobBy]        		 NVARCHAR (128),
    [t_extractionDtm]		 DATETIME,
    [t_filePath]             NVARCHAR (1024),
    CONSTRAINT [PK_I_InventoryValuationType]  PRIMARY KEY NONCLUSTERED (
        [InventoryValuationType]
    ) NOT ENFORCED
) WITH (
  HEAP
)
