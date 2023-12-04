CREATE TABLE [base_s4h_cax].[P_SU2X_HEAD_TR] (    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [object] NVARCHAR(4) NOT NULL  -- Object Type
  , [obj_name] NVARCHAR(40) NOT NULL  -- Object Name in Object Directory
  , [modifier] NVARCHAR(12)  -- Last Changed By
  , [moddate] DATE  -- Modification date
  , [modtime] TIME(6)  -- Modification time
  , [okflag] NVARCHAR(1)  -- Maintenance Mode
  , [al_vers] NVARCHAR(1)  -- ABAP Language Version
  , [devclass] NVARCHAR(30)  -- Package
  , [dlvunit] NVARCHAR(30)  -- Software Component
  , [ps_posid] NVARCHAR(24)  -- Application component ID
  , [srcsystem] NVARCHAR(10)  -- Original System of Object
  , [author] NVARCHAR(12)  -- Person Responsible for a Repository Object
  , [masterlang] CHAR(1)  -- Original Language in Repository objects
  , [stext] NVARCHAR(36)  -- Transaction text
  , [cinfo] BINARY(1)  -- HEX01 data element for SYST
  , [x_cnt] INT
  , [x_cnt_c] INT
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_P_SU2X_HEAD_TR] PRIMARY KEY NONCLUSTERED(      
      [MANDT]
    , [object]
    , [obj_name]
  ) NOT ENFORCED
) WITH (
  HEAP
)