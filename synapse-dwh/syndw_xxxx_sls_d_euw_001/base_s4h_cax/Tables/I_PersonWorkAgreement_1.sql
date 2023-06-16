CREATE TABLE [base_s4h_cax].[I_PersonWorkAgreement_1] (
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [Person] NVARCHAR(10)  --  Business Partner Number
  , [PersonFullName] NVARCHAR(80)  -- Full Name
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_PersonWorkAgreement_1] PRIMARY KEY NONCLUSTERED(
      [MANDT]
  ) NOT ENFORCED
) WITH (
  HEAP
)
