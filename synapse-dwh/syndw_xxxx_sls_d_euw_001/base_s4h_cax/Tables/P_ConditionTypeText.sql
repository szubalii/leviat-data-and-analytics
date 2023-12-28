CREATE TABLE [base_s4h_cax].[P_ConditionTypeText](
  [MANDT] char(3) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [SPRAS] char(3) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [KSCHL] char(4) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [KAPPL] char(2) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [KVEWE] char(1) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [ACMPRICINGCONDITIONTYPENAME] char(30) --COLLATE Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_P_ConditionTypeText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [SPRAS], [KSCHL], [KAPPL], [KVEWE]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
