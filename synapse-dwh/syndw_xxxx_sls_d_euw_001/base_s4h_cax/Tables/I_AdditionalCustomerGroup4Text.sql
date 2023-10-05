CREATE TABLE [base_s4h_cax].[I_AdditionalCustomerGroup4Text](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [AdditionalCustomerGroup4] nvarchar(3) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [AdditionalCustomerGroup4Name] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_AdditionalCustomerGroup4Text] PRIMARY KEY NONCLUSTERED (
    [MANDT], [AdditionalCustomerGroup4], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
