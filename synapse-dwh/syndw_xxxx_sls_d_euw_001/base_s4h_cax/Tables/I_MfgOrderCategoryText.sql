CREATE TABLE [base_s4h_cax].[I_MfgOrderCategoryText]
(
  [ManufacturingOrderCategory]      CHAR(2) NOT NULL --        COLLATE Latin1_General_100_BIN2  NOT NULL
, [Language]                        NCHAR(1) NOT NULL --       COLLATE Latin1_General_100_BIN2  NOT NULL
, [ManufacturingOrderCategoryName]  NVARCHAR(60) --   COLLATE Latin1_General_100_BIN2
, [t_applicationId]                 VARCHAR (32)
, [t_jobId]                         VARCHAR (36)
, [t_jobDtm]                        DATETIME
, [t_jobBy]        		            NVARCHAR (128)
, [t_extractionDtm]		            DATETIME
, [t_filePath]                      NVARCHAR (1024)
, CONSTRAINT [PK_I_MfgOrderCategoryText] PRIMARY KEY NONCLUSTERED([ManufacturingOrderCategory],[Language]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
