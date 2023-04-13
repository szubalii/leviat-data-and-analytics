CREATE TABLE [base_s4h_cax].[I_MRPController] (
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [Plant] NVARCHAR(4) NOT NULL  -- Plant
  , [MRPController] NVARCHAR(3) NOT NULL  -- MRP Controller
  , [MRPControllerName] NVARCHAR(18)  -- MRP Controller Name
  , [MRPControllerPhoneNumber] NVARCHAR(12)  -- MRP Controller's Phone Number
  , [PurchasingGroup] NVARCHAR(3)  -- Purchasing Group
  , [BusinessArea] NVARCHAR(4)  -- Business Area
  , [ProfitCenter] NVARCHAR(10)  -- Profit Center
  , [UserID] NVARCHAR(70)  -- Object ID for recipient
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_MRPController] PRIMARY KEY NONCLUSTERED(      
      [MANDT]
    , [Plant]
    , [MRPController]
  ) NOT ENFORCED
) WITH (
  HEAP
)