CREATE TABLE [base_s4h_cax].[Opt_Vim_2Head]
(
    MANDT                   NVARCHAR(3)                
    ,DocID                  NVARCHAR(12)                
    ,DOCTYPE                NVARCHAR(10)
    ,BELNR_MM               NVARCHAR(10)   
    ,BELNR_FI               NVARCHAR(10)   
    ,POSTING_USER           NVARCHAR(12)
    , [t_applicationId]     VARCHAR (32)
    , [t_jobId]             VARCHAR (36)
    , [t_jobDtm]            DATETIME
    , [t_jobBy]             NVARCHAR (128)
    , [t_filePath]          NVARCHAR (1024)
    , [t_extractionDtm]     DATETIME
    , CONSTRAINT [PK_OPT_VIM_2HEAD] PRIMARY KEY NONCLUSTERED (
    [MANDT], [DocID]
  ) NOT ENFORCED
)
WITH ( 
  HEAP
)
