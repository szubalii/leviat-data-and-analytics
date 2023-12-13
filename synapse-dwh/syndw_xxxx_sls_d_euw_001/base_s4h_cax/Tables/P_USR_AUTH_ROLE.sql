CREATE TABLE [base_s4h_cax].[P_USR_AUTH_ROLE] (    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [BName] NVARCHAR(12) NOT NULL -- User Name in User Master Record
  , [Profile] NVARCHAR(12) NOT NULL-- Profile name
  , [Agr_Name] NVARCHAR(30)  -- Role Name
  , [RefUser] NVARCHAR(12)  -- Reference user
  , [From_Dat] DATE NOT NULL-- Date of validity
  , [To_Dat] DATE  -- Date of validity
  , [Col_Flag] NVARCHAR(1)  -- Flag: Assignment from composite role
  , [Org_Flag] NVARCHAR(1)  -- Flag: Assignment Comes From HR Organization Management
  , [Text] NVARCHAR(80)  -- Role Description
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_P_USR_AUTH_ROLE] PRIMARY KEY NONCLUSTERED(      
      [MANDT],
      [BName],
      [Profile],
      [From_Dat]
  ) NOT ENFORCED
) WITH (
  HEAP
)