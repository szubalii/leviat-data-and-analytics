CREATE TABLE [base_s4h_cax].[C_MfgOrderObjPgOpr]
(
  [MANDT] NCHAR(3) NOT NULL -- COLLATE Latin1_General_100_BIN2 NOT NULL
, [OrderInternalBillOfOperations] CHAR(10) NOT NULL -- COLLATE Latin1_General_100_BIN2 NOT NULL
, [OrderIntBillOfOperationsItem] CHAR(8) NOT NULL -- COLLATE Latin1_General_100_BIN2 NOT NULL
, [ManufacturingOrder] NVARCHAR(12) -- COLLATE Latin1_General_100_BIN2
, [ManufacturingOrderOperation] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderOperationIsPhase] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [ManufacturingOrderSequence] NVARCHAR(6) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderSequenceCategoryName] NVARCHAR(30) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderSequenceText] NVARCHAR(40) -- COLLATE Latin1_General_100_BIN2
, [MfgOrderOperationText] NVARCHAR(40) -- COLLATE Latin1_General_100_BIN2
, [ManufacturingOrderType] NVARCHAR(4) -- COLLATE Latin1_General_100_BIN2
, [BusinessProcessEntryUnit] NVARCHAR(3) -- COLLATE Latin1_General_100_BIN2
, [ManufacturingOrderCategory] CHAR(2) -- COLLATE Latin1_General_100_BIN2
, [Material] NVARCHAR(40) -- COLLATE Latin1_General_100_BIN2
, [WorkCenterTypeCode] NVARCHAR(1) -- COLLATE Latin1_General_100_BIN2
, [WorkCenterTypeName] NVARCHAR(60) -- COLLATE Latin1_General_100_BIN2
, [WorkCenter] NVARCHAR(8) -- COLLATE Latin1_General_100_BIN2
, [OpErlstSchedldExecStrtDte] DATE
, [OpErlstSchedldExecStrtTme] TIME(0)
, [OpErlstSchedldExecEndDte] DATE
, [OpErlstSchedldExecEndTme] TIME(0)
, [OpActualExecutionStartDate] DATE
, [OpActualExecutionStartTime] TIME(0)
, [OpActualExecutionEndDate] DATE
, [OpActualExecutionEndTime] TIME(0)
, [OperationUnit] NVARCHAR(3) -- COLLATE Latin1_General_100_BIN2
, [OpPlannedTotalQuantity] DECIMAL(13,3)
, [ErlstSchedldExecDurnInWorkdays] INT
, [OpActualExecutionDays] INT
, [OpTotalConfirmedYieldQty] DECIMAL(13,3)
, [WorkCenterInternalID] CHAR(8) -- COLLATE Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_C_MfgOrderObjPgOpr] PRIMARY KEY NONCLUSTERED (
    [MANDT], [OrderInternalBillOfOperations], [OrderIntBillOfOperationsItem]
  ) NOT ENFORCED
)
WITH (
  HEAP
)

