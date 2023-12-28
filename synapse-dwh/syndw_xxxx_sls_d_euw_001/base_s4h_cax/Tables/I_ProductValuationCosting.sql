CREATE TABLE [base_s4h_cax].[I_ProductValuationCosting]
-- Product Valuation Costing Core Entity
(
  [MANDT] nchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Product] nvarchar(40) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ValuationArea] nvarchar(4) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ValuationType] nvarchar(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [IsMaterialCostedWithQtyStruc] nvarchar(1) -- collate Latin1_General_100_BIN2
, [IsMaterialRelatedOrigin] nvarchar(1) -- collate Latin1_General_100_BIN2
, [CostOriginGroup] nvarchar(4) -- collate Latin1_General_100_BIN2
, [CostingOverheadGroup] nvarchar(10) -- collate Latin1_General_100_BIN2
, [t_applicationId]      VARCHAR (32)
, [t_jobId]              VARCHAR (36)
, [t_jobDtm]             DATETIME
, [t_jobBy]              NVARCHAR (128)
, [t_filePath]           NVARCHAR (1024)
, [t_extractionDtm]      DATETIME
, CONSTRAINT [PK_I_ProductValuationCosting] PRIMARY KEY NONCLUSTERED([MANDT],[Product],[ValuationArea],[ValuationType]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
