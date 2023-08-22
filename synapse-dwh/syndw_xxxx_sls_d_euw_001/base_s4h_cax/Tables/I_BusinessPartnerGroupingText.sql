CREATE TABLE [base_s4h_cax].[I_BusinessPartnerGroupingText]
(
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [LANGUAGE]  CHAR(1) NOT NULL -- Language Key  
  , [BUSINESSPARTNERGROUPING] NVARCHAR(4) NOT NULL  -- Business Partner Grouping
  , [BUSINESSPARTNERGROUPINGTEXT] NVARCHAR(40) NOT NULL  -- Description
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_BusinessPartnerGroupingText] PRIMARY KEY NONCLUSTERED
  (
      [MANDT]
    , [LANGUAGE]
    , [BUSINESSPARTNERGROUPING]
  ) NOT ENFORCED
) WITH (
  HEAP
)
