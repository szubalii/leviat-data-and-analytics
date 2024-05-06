CREATE TABLE [base_dw_halfen_1_stg].[AX_Halfen_dbo_COMPANYINFO](
  [DW_Id]              BIGINT            NOT NULL,
  [DATAAREAID]         NVARCHAR   (4)    NULL,
  [CURRENCYCODE]       NVARCHAR   (3)    NULL,
  [SHIPPINGCALENDARID] NVARCHAR   (10)   NULL,
  [DW_Batch]           BIGINT            NULL,
  [DW_SourceCode]      VARCHAR    (15)   NOT NULL,
  [DW_TimeStamp]       DATETIME          NOT NULL,
	[t_applicationId]    VARCHAR    (32)   NULL,
  [t_jobId]            VARCHAR    (36)   NULL,
  [t_jobDtm]           DATETIME,
  [t_jobBy]            NVARCHAR  (128)   NULL,
  [t_extractionDtm]    DATETIME,
  [t_filePath]         NVARCHAR (1024)   NULL,
  CONSTRAINT [PK_AX_Halfen_dbo_COMPANYINFO] PRIMARY KEY NONCLUSTERED (
    [DW_Id] ASC
  ) NOT ENFORCED
)
WITH(
  HEAP,
  DISTRIBUTION = REPLICATE
)
