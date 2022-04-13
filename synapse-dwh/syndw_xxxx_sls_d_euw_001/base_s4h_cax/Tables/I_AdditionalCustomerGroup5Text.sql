CREATE TABLE [base_s4h_cax].[I_AdditionalCustomerGroup5Text](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [AdditionalCustomerGroup5] nvarchar(3) NOT NULL
, [Language] char(1) collate  Latin1_General_100_BIN2 NOT NULL
, [AdditionalCustomerGroup5Name] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_AdditionalCustomerGroup5Text] PRIMARY KEY NONCLUSTERED (
    [MANDT], [AdditionalCustomerGroup5], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
