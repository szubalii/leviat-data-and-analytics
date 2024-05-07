CREATE TABLE [base_s4h_cax].[C_CnsldtnProfitCenter](
  [MANDT] CHAR(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ProfitCenter] NVARCHAR(10) NOT NULL
, [ControllingArea] NVARCHAR(4) NOT NULL
, [AdditionalMasterDataText] NVARCHAR(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_C_CnsldtnProfitCenter] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ProfitCenter], [ControllingArea]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
