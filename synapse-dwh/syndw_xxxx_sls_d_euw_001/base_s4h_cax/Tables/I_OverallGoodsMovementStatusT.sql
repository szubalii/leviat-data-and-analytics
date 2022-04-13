CREATE TABLE [base_s4h_cax].[I_OverallGoodsMovementStatusT]
-- Overall Goods Movement Status Text
(
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [OverallGoodsMovementStatus] nvarchar(1) NOT NULL
, [Language] char(1) collate  Latin1_General_100_BIN2 NOT NULL
, [OverallGoodsMovementStatusDesc] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_OverallGoodsMovementStatusT] PRIMARY KEY NONCLUSTERED([MANDT],[OverallGoodsMovementStatus],[Language]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
