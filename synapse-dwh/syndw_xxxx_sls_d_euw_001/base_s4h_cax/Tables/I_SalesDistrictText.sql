CREATE TABLE [base_s4h_cax].[I_SalesDistrictText](
  [MANDT] char(3)         collate Latin1_General_100_BIN2 NOT NULL
, [SalesDistrict]         nvarchar(6) NOT NULL
, [Language]              char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [SalesDistrictName]     nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		    NVARCHAR (128)
, [t_extractionDtm]		    DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_SalesDistrictText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [SalesDistrict], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
