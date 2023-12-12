CREATE TABLE [base_s4h_cax].[P_USR_AUTH_ROLE] (    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [BNAME] NVARCHAR(12) NOT NULL -- User Name in User Master Record
  , [profile] NVARCHAR(12) NOT NULL-- Profile name
  , [agr_name] NVARCHAR(30)  -- Role Name
  , [refuser] NVARCHAR(12)  -- Reference user
  , [from_dat] DATE NOT NULL-- Date of validity
  , [to_dat] DATE  -- Date of validity
  , [col_flag] NVARCHAR(1)  -- Flag: Assignment from composite role
  , [org_flag] NVARCHAR(1)  -- Flag: Assignment Comes From HR Organization Management
  , [text] NVARCHAR(80)  -- Role Description
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_P_USR_AUTH_ROLE] PRIMARY KEY NONCLUSTERED(      
      [MANDT],
      [BNAME],
      [profile],
      [from_dat]
  ) NOT ENFORCED
) WITH (
  HEAP
)
