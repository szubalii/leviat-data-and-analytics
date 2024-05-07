CREATE TABLE [base_s4h_cax].[I_WorkCenterBySemanticKey]
(
  [MANDT] NCHAR(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Plant] NVARCHAR(4) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [WorkCenter] NVARCHAR(8) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [WorkCenterInternalID] CHAR(8) -- collate Latin1_General_100_BIN2
, [WorkCenterTypeCode] NVARCHAR(2) -- collate Latin1_General_100_BIN2
, [WorkCenterIsToBeDeleted] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [WorkCenterIsLocked] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [WorkCenterIsMntndForCosting] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [WorkCenterIsMntndForScheduling] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [NumberOfConfirmationSlips] CHAR(3) -- collate Latin1_General_100_BIN2
, [AdvancedPlanningIsSupported] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [WorkCenterCategoryCode] NVARCHAR(4) -- collate Latin1_General_100_BIN2
, [WorkCenterLocation] NVARCHAR(10) -- collate Latin1_General_100_BIN2
, [WorkCenterLocationGroup] NVARCHAR(4) -- collate Latin1_General_100_BIN2
, [WorkCenterUsage] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [WorkCenterResponsible] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [SupplyArea] NVARCHAR(10) -- collate Latin1_General_100_BIN2
, [CapacityInternalID] CHAR(8) -- collate Latin1_General_100_BIN2
, [MachineType] NVARCHAR(10) -- collate Latin1_General_100_BIN2
, [OperationControlProfile] NVARCHAR(4) -- collate Latin1_General_100_BIN2
, [MatlCompIsMarkedForBackflush] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [WorkCenterSetupType] NVARCHAR(2) -- collate Latin1_General_100_BIN2
, [FreeDefinedTableFieldSemantic] NVARCHAR(7) -- collate Latin1_General_100_BIN2
, [ObjectInternalID] NVARCHAR(22) -- collate Latin1_General_100_BIN2
, [StandardTextInternalID] NVARCHAR(7) -- collate Latin1_General_100_BIN2
, [EmployeeWageType] NVARCHAR(4) -- collate Latin1_General_100_BIN2
, [EmployeeWageGroup] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [EmployeeSuitability] NVARCHAR(2) -- collate Latin1_General_100_BIN2
, [NumberOfTimeTickets] DECIMAL(3)
, [PlanVersion] NVARCHAR(2) -- collate Latin1_General_100_BIN2
, [ValidityStartDate] DATE
, [ValidityEndDate] DATE
, [StandardTextIDIsReferenced] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [EmployeeWageTypeIsReferenced] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [NmbrOfTimeTicketsIsReferenced] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [EmployeeWageGroupIsReferenced] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [EmplSuitabilityIsReferenced] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [WorkCenterSetpTypeIsReferenced] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [OpControlProfileIsReferenced] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [NumberOfConfSlipsIsReferenced] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [WorkCenterStdQueueDurnUnit] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [WorkCenterStandardQueueDurn] DECIMAL(9,3)
, [WorkCenterMinimumQueueDurnUnit] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [WorkCenterMinimumQueueDuration] DECIMAL(9,3)
, [WorkCenterStandardWorkQtyUnit1] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit2] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit3] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit4] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit5] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit6] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [StandardWorkQuantityUnit] NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [LaborTrackingIsRequired] NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_WorkCenterBySemanticKey] PRIMARY KEY NONCLUSTERED (
    [MANDT],[Plant],[WorkCenter]
  ) NOT ENFORCED
)
WITH (
  HEAP
)

