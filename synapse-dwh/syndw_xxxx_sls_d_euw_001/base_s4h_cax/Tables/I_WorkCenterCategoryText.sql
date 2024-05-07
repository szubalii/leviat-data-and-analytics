CREATE TABLE [base_s4h_cax].[I_WorkCenterCategoryText]
(
  [MANDT]                       NCHAR(3) NOT NULL -- COLLATE Latin1_General_100_BIN2     NOT NULL
, [WorkCenterCategoryCode]      NVARCHAR (4) NOT NULL -- COLLATE Latin1_General_100_BIN2     NOT NULL
, [Language]                    NCHAR(1) NOT NULL -- COLLATE Latin1_General_100_BIN2     NOT NULL
, [WorkCenterCategoryName]      NVARCHAR (20) -- collate Latin1_General_100_BIN2
, [t_applicationId]             VARCHAR (32)
, [t_jobId]                     VARCHAR (36)
, [t_jobDtm]                    DATETIME
, [t_jobBy]        		        NVARCHAR (128)
, [t_extractionDtm]		        DATETIME
, [t_filePath]                  NVARCHAR (1024)
, CONSTRAINT [PK_I_WorkCenterCategoryText] PRIMARY KEY NONCLUSTERED([MANDT],[WorkCenterCategoryCode],[Language]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
