CREATE TABLE [base_s4h_cax].[I_ControllingArea](
  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
, [ODQ_CHANGEMODE] CHAR(1)
, [ODQ_ENTITYCNTR] NUMERIC(19,0)
, [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ControllingArea] nvarchar(4) NOT NULL
, [FiscalYearVariant] nvarchar(2)
, [ControllingAreaName] nvarchar(25)
, [ControllingAreaCurrency] char(5) -- collate Latin1_General_100_BIN2
, [ChartOfAccounts] nvarchar(4)
, [CostCenterStandardHierarchy] nvarchar(12)
, [ProfitCenterStandardHierarchy] nvarchar(12)
, [FinancialManagementArea] nvarchar(4)
, [ControllingAreaCurrencyRole] nvarchar(2)
, [CtrlgStdFinStatementVersion] nvarchar(42)
, [ProfitCenterAccountingCurrency] char(5) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ControllingArea] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER], [MANDT], [ControllingArea]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
