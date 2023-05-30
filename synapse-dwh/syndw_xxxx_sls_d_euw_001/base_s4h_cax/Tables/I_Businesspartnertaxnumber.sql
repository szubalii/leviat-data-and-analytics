CREATE TABLE [base_s4h_cax].[I_Businesspartnertaxnumber] 
(
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [BUSINESSPARTNER] NVARCHAR(10) NOT NULL  -- Business Partner Number
  , [BPTAXTYPE] NVARCHAR(4) NOT NULL  -- Tax Number Category
  , [BPTAXNUMBER] NVARCHAR(20)  -- Business Partner Tax Number
  , [BPTAXLONGNUMBER] NVARCHAR(60)  -- Business Partner Tax Number
  , [AUTHORIZATIONGROUP] NVARCHAR(4)  -- Authorization Group
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_Businesspartnertaxnumber] PRIMARY KEY NONCLUSTERED
  (
      [MANDT]
    , [BUSINESSPARTNER]
    , [BPTAXTYPE]
  ) NOT ENFORCED
) WITH (
  HEAP
)
