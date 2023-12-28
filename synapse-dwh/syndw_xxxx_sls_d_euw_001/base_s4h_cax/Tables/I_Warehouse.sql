CREATE TABLE [base_s4h_cax].[I_Warehouse]
-- Warehouse
(
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Warehouse] nvarchar(3) NOT NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_Warehouse] PRIMARY KEY NONCLUSTERED([MANDT],[Warehouse]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
