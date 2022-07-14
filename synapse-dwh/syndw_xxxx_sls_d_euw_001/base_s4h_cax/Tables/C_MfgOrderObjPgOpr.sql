CREATE TABLE [base_s4h_cax].[C_MfgOrderObjPgOpr]
(
  [MANDT] nchar(3) collate Latin1_General_100_BIN2 NOT NULL
, [OrderInternalBillOfOperations] char(10) collate Latin1_General_100_BIN2 NOT NULL
, [OrderIntBillOfOperationsItem] char(8) collate Latin1_General_100_BIN2 NOT NULL
, [ManufacturingOrder] nvarchar(12) collate Latin1_General_100_BIN2
, [ManufacturingOrderOperation] nvarchar(4) collate Latin1_General_100_BIN2
, [MfgOrderOperationIsPhase] nvarchar(1) collate Latin1_General_100_BIN2
, [ManufacturingOrderSequence] nvarchar(6) collate Latin1_General_100_BIN2
, [MfgOrderSequenceCategoryName] nvarchar(30) collate Latin1_General_100_BIN2
, [MfgOrderSequenceText] nvarchar(40) collate Latin1_General_100_BIN2
, [MfgOrderOperationText] nvarchar(40) collate Latin1_General_100_BIN2
, [ManufacturingOrderType] nvarchar(4) collate Latin1_General_100_BIN2
, [BusinessProcessEntryUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [ManufacturingOrderCategory] char(2) collate Latin1_General_100_BIN2
, [Material] nvarchar(40) collate Latin1_General_100_BIN2
, [WorkCenterTypeCode] nvarchar(1) collate Latin1_General_100_BIN2
, [WorkCenterTypeName] nvarchar(60) collate Latin1_General_100_BIN2
, [WorkCenter] nvarchar(8) collate Latin1_General_100_BIN2
, [OpErlstSchedldExecStrtDte] date
, [OpErlstSchedldExecStrtTme] time(0)
, [OpErlstSchedldExecEndDte] date
, [OpErlstSchedldExecEndTme] time(0)
, [OpActualExecutionStartDate] date
, [OpActualExecutionStartTime] time(0)
, [OpActualExecutionEndDate] date
, [OpActualExecutionEndTime] time(0)
, [OperationUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [OpPlannedTotalQuantity] decimal(13,3)
, [ErlstSchedldExecDurnInWorkdays] int
, [OpActualExecutionDays] int
, [OpTotalConfirmedYieldQty] decimal(13,3)
, [WorkCenterInternalID] char(8) collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_lastDtm]             DATETIME
, [t_lastActionBy]        VARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_C_MfgOrderObjPgOpr] PRIMARY KEY NONCLUSTERED (
    [MANDT], [OrderInternalBillOfOperations], [OrderIntBillOfOperationsItem]
  ) NOT ENFORCED
)
WITH (
  HEAP
)

