CREATE TABLE [base_s4h_cax].[I_ACMAuthznDataForActivityGrp] (    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [LOGACCMACTYGRPPROFILEROLENAME] NVARCHAR(30) NOT NULL  -- Role Name
  , [LOGACCMACTYGRPPRFLCHGSTINTID] CHAR(6) NOT NULL  -- Menu ID for BIW
  , [AUTHORIZATIONGROUPOBJECT] NVARCHAR(10)  -- Auth. Object in User Master Maintenance
  , [AUTHORIZATIONFROMVALUE] NVARCHAR(40)  -- Authorization value
  , [AUTHORIZATIONTOVALUE] NVARCHAR(40)  -- Authorization value
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_ACMAuthznDataForActivityGrp] PRIMARY KEY NONCLUSTERED(      
      [MANDT]
    , [LOGACCMACTYGRPPROFILEROLENAME]
    , [LOGACCMACTYGRPPRFLCHGSTINTID]
  ) NOT ENFORCED
) WITH (
  HEAP
)