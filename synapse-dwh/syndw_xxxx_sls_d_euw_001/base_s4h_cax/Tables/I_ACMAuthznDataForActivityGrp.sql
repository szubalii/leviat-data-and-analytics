CREATE TABLE [base_s4h_cax].[I_ACMAuthznDataForActivityGrp] (    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [LogAccmActyGrpProfileRolename] NVARCHAR(30) NOT NULL  -- Role Name
  , [LogAccmActyGrpPrflChgsTintId] CHAR(6) NOT NULL  -- Menu ID for BIW
  , [AuthorizationGroupObject] NVARCHAR(10)  -- Auth. Object in User Master Maintenance
  , [AuthorizationFromValue] NVARCHAR(40)  -- Authorization value
  , [AuthorizationToValue] NVARCHAR(40)  -- Authorization value
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_ACMAuthznDataForActivityGrp] PRIMARY KEY NONCLUSTERED(      
      [MANDT]
    , [LogAccmActyGrpProfileRolename]
    , [LogAccmActyGrpPrflChgsTintId]
  ) NOT ENFORCED
) WITH (
  HEAP
)