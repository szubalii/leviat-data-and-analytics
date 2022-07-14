CREATE TABLE [base_s4h_cax].[I_WorkCenterBySemanticKey]
(
  [MANDT] nchar(3) collate Latin1_General_100_BIN2 NOT NULL
, [Plant] nvarchar(4) collate Latin1_General_100_BIN2 NOT NULL
, [WorkCenter] nvarchar(8) collate Latin1_General_100_BIN2 NOT NULL
, [WorkCenterInternalID] char(8) collate Latin1_General_100_BIN2
, [WorkCenterTypeCode] nvarchar(2) collate Latin1_General_100_BIN2
, [WorkCenterIsToBeDeleted] nvarchar(1) collate Latin1_General_100_BIN2
, [WorkCenterIsLocked] nvarchar(1) collate Latin1_General_100_BIN2
, [WorkCenterIsMntndForCosting] nvarchar(1) collate Latin1_General_100_BIN2
, [WorkCenterIsMntndForScheduling] nvarchar(1) collate Latin1_General_100_BIN2
, [NumberOfConfirmationSlips] char(3) collate Latin1_General_100_BIN2
, [AdvancedPlanningIsSupported] nvarchar(1) collate Latin1_General_100_BIN2
, [WorkCenterCategoryCode] nvarchar(4) collate Latin1_General_100_BIN2
, [WorkCenterLocation] nvarchar(10) collate Latin1_General_100_BIN2
, [WorkCenterLocationGroup] nvarchar(4) collate Latin1_General_100_BIN2
, [WorkCenterUsage] nvarchar(3) collate Latin1_General_100_BIN2
, [WorkCenterResponsible] nvarchar(3) collate Latin1_General_100_BIN2
, [SupplyArea] nvarchar(10) collate Latin1_General_100_BIN2
, [CapacityInternalID] char(8) collate Latin1_General_100_BIN2
, [MachineType] nvarchar(10) collate Latin1_General_100_BIN2
, [OperationControlProfile] nvarchar(4) collate Latin1_General_100_BIN2
, [MatlCompIsMarkedForBackflush] nvarchar(1) collate Latin1_General_100_BIN2
, [WorkCenterSetupType] nvarchar(2) collate Latin1_General_100_BIN2
, [FreeDefinedTableFieldSemantic] nvarchar(7) collate Latin1_General_100_BIN2
, [ObjectInternalID] nvarchar(22) collate Latin1_General_100_BIN2
, [StandardTextInternalID] nvarchar(7) collate Latin1_General_100_BIN2
, [EmployeeWageType] nvarchar(4) collate Latin1_General_100_BIN2
, [EmployeeWageGroup] nvarchar(3) collate Latin1_General_100_BIN2
, [EmployeeSuitability] nvarchar(2) collate Latin1_General_100_BIN2
, [NumberOfTimeTickets] decimal(3)
, [PlanVersion] nvarchar(2) collate Latin1_General_100_BIN2
, [ValidityStartDate] date
, [ValidityEndDate] date
, [StandardTextIDIsReferenced] nvarchar(1) collate Latin1_General_100_BIN2
, [EmployeeWageTypeIsReferenced] nvarchar(1) collate Latin1_General_100_BIN2
, [NmbrOfTimeTicketsIsReferenced] nvarchar(1) collate Latin1_General_100_BIN2
, [EmployeeWageGroupIsReferenced] nvarchar(1) collate Latin1_General_100_BIN2
, [EmplSuitabilityIsReferenced] nvarchar(1) collate Latin1_General_100_BIN2
, [WorkCenterSetpTypeIsReferenced] nvarchar(1) collate Latin1_General_100_BIN2
, [OpControlProfileIsReferenced] nvarchar(1) collate Latin1_General_100_BIN2
, [NumberOfConfSlipsIsReferenced] nvarchar(1) collate Latin1_General_100_BIN2
, [WorkCenterStdQueueDurnUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [WorkCenterStandardQueueDurn] decimal(9,3)
, [WorkCenterMinimumQueueDurnUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [WorkCenterMinimumQueueDuration] decimal(9,3)
, [WorkCenterStandardWorkQtyUnit1] nvarchar(3) collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit2] nvarchar(3) collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit3] nvarchar(3) collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit4] nvarchar(3) collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit5] nvarchar(3) collate Latin1_General_100_BIN2
, [WorkCenterStandardWorkQtyUnit6] nvarchar(3) collate Latin1_General_100_BIN2
, [StandardWorkQuantityUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [LaborTrackingIsRequired] nvarchar(1) collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_lastDtm]             DATETIME
, [t_lastActionBy]        VARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_WorkCenterBySemanticKey] PRIMARY KEY NONCLUSTERED (
    [MANDT],[Plant],[WorkCenter]
  ) NOT ENFORCED
)
WITH (
  HEAP
)

