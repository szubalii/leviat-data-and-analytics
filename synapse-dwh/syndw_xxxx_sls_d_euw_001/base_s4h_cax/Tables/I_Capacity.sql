CREATE TABLE [base_s4h_cax].[I_Capacity]
(
  [MANDT]                           NCHAR(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CapacityInternalID]              CHAR(8) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Capacity]                        NVARCHAR(8) -- collate Latin1_General_100_BIN2
, [CapacityCategoryCode]            NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [CapacityActiveVersion]           CHAR(2) -- collate Latin1_General_100_BIN2
, [CapacityIsFinite]                NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [CapacityIsPooled]                NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [CapacityHasIndivCapacities]      NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [CapacityIsExcldFrmLongTermPlng]  NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [CapacityNumberOfCapacities]      SMALLINT
, [CapacityResponsiblePlanner]      NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [CapacityPlanUtilizationPercent]  CHAR(3) -- collate Latin1_General_100_BIN2
, [CapacityBreakDuration]           INT
, [CapIsUsedInMultiOperations]      NVARCHAR(1) -- collate Latin1_General_100_BIN2
, [ReferencedCapacityInternalID]    CHAR(8) -- collate Latin1_General_100_BIN2
, [CapOverloadThresholdInPercent]   CHAR(3) -- collate Latin1_General_100_BIN2
, [Plant]                           NVARCHAR(4) -- collate Latin1_General_100_BIN2
, [FactoryCalendar]                 NVARCHAR(2) -- collate Latin1_General_100_BIN2
, [AuthorizationGroup]              NVARCHAR(4) -- collate Latin1_General_100_BIN2
, [ShiftGroup]                      NVARCHAR(2) -- collate Latin1_General_100_BIN2
, [CapacityStartTime]               INT
, [CapacityEndTime]                 INT
, [CapacityQuantityUnit]            NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [CapacityBaseQtyUnit]             NVARCHAR(3) -- collate Latin1_General_100_BIN2
, [CapacityLastChangeDateTime]      DECIMAL(21,7)
, [t_applicationId]                 VARCHAR (32)
, [t_jobId]                         VARCHAR (36)
, [t_jobDtm]                        DATETIME
, [t_jobBy]        		            NVARCHAR (128)
, [t_extractionDtm]		            DATETIME
, [t_filePath]                      NVARCHAR (1024)
, CONSTRAINT [PK_I_Capacity] PRIMARY KEY NONCLUSTERED([MANDT],[CapacityInternalID]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
