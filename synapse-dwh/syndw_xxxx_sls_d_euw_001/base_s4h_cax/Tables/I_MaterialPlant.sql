CREATE TABLE [base_s4h_cax].[I_MaterialPlant](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Material] nvarchar(40) NOT NULL
, [Plant] nvarchar(4) NOT NULL
, [MRPController] nvarchar(3)
, [MaterialSafetyStockQty] decimal(13,3)
, [DfltStorLocForExtProcmt] nvarchar(4)
, [MaterialABCClassification] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_MaterialPlant] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Material], [Plant]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
