CREATE TABLE [base_s4h_cax].[I_FinancialStatementHierT](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [FinancialStatementHierarchy] nvarchar(42) NOT NULL
, [ValidityEndDate] date NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ValidityStartDate] date
, [FinancialStmntHierarchyName] nvarchar(50)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_FinancialStatementHierT] PRIMARY KEY NONCLUSTERED (
    [MANDT], [FinancialStatementHierarchy], [ValidityEndDate], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
