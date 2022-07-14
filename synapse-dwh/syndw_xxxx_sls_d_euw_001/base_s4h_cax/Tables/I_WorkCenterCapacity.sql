CREATE TABLE [base_s4h_cax].[I_WorkCenterCapacity]
(
  [MANDT] nchar(3) collate Latin1_General_100_BIN2 NOT NULL
, [WorkCenterInternalID] char(8) collate Latin1_General_100_BIN2 NOT NULL
, [WorkCenterTypeCode] nvarchar(2) collate Latin1_General_100_BIN2 NOT NULL
, [CapacityCategoryAllocation] char(4) collate Latin1_General_100_BIN2 NOT NULL
, [LastChangeDate] date
, [LastChangedByUser] nvarchar(12) collate Latin1_General_100_BIN2
, [Plant] nvarchar(4) collate Latin1_General_100_BIN2
, [WorkCenter] nvarchar(8) collate Latin1_General_100_BIN2
, [WorkCenterCategoryCode] nvarchar(4) collate Latin1_General_100_BIN2
, [CapacityInternalID] char(8) collate Latin1_General_100_BIN2
, [CapacityCategoryCode] nvarchar(3) collate Latin1_General_100_BIN2
, [Capacity] nvarchar(8) collate Latin1_General_100_BIN2
, [SetupCapRequirementFormula] nvarchar(6) collate Latin1_General_100_BIN2
, [ProcgCapRequirementFormula] nvarchar(6) collate Latin1_General_100_BIN2
, [TeardownCapRequirementFormula] nvarchar(6) collate Latin1_General_100_BIN2
, [OtherCapRequirementFormula] nvarchar(6) collate Latin1_General_100_BIN2
, [ValidityStartDate] date
, [ValidityEndDate] date
, [CapacityQuantityUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [WorkCenterLastChangeDateTime] decimal(21,7)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_lastDtm]             DATETIME
, [t_lastActionBy]        VARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_WorkCenterCapacity] PRIMARY KEY NONCLUSTERED (
    [MANDT],[WorkCenterInternalID],[WorkCenterTypeCode],[CapacityCategoryAllocation]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
