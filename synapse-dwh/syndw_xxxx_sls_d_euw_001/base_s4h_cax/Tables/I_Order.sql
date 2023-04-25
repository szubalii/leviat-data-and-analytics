CREATE TABLE [base_s4h_cax].[I_Order] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [OrderID] NVARCHAR(12) NOT NULL  -- Order Number
  , [OrderCategory] CHAR(2)  -- Order Category
  , [OrderType] NVARCHAR(4)  -- Order Type
  , [OrderInternalID] CHAR(10)  -- Order Internal ID
  , [OrderDescription] NVARCHAR(40)  -- Order Description
  , [Plant] NVARCHAR(4)  -- Plant
  , [MRPController] NVARCHAR(3)  -- MRP Controller
  , [ControllingArea] NVARCHAR(4)  -- Controlling Area
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_Order] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [OrderID]
  ) NOT ENFORCED
) 
WITH (
  HEAP
)