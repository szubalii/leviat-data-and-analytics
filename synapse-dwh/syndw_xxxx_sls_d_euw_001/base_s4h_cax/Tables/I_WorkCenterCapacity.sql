CREATE TABLE [base_s4h_cax].[I_WorkCenterCapacity]
(
  [MANDT] NCHAR(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [WorkCenterInternalID] CHAR(8) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [WorkCenterTypeCode] NVARCHAR(2) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CapacityCategoryAllocation] CHAR(4) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [LastChangeDate] DATE
, [LastChangedByUser] NVARCHAR(12) -- collate Latin1_General_100_BIN2
, [Plant] NVARCHAR(4) -- collate Latin1_General_100_BIN2
, [WorkCenter] NVARCHAR(8) -- collate Latin1_General_100_BIN2
, [WorkCenterCategoryCode] NVARCHAR(4) -- collate Latin1_General_100_BIN2
, [CapacityInternalID] CHAR(8) -- collate Latin1_General_100_BIN2
, [CapacityCategoryCode] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [Capacity] NVARCHAR(8) -- collate Latin1_General_100_BIN2
, [SetupCapRequirementFormula] NVARCHAR(6) -- collate Latin1_General_100_BIN2
, [ProcgCapRequirementFormula] NVARCHAR(6) -- collate Latin1_General_100_BIN2
, [TeardownCapRequirementFormula] NVARCHAR(6) -- collate Latin1_General_100_BIN2
, [OtherCapRequirementFormula] NVARCHAR(6) -- collate Latin1_General_100_BIN2
, [ValidityStartDate] DATE
, [ValidityEndDate] DATE
, [CapacityQuantityUnit] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_WorkCenterCapacity] PRIMARY KEY NONCLUSTERED (
    [MANDT],[WorkCenterInternalID],[WorkCenterTypeCode],[CapacityCategoryAllocation]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
