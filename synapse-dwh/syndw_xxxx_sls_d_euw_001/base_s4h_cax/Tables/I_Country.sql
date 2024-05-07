CREATE TABLE [base_s4h_cax].[I_Country](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Country] nvarchar(3) NOT NULL
, [CountryThreeLetterISOCode] nvarchar(3)
, [CountryThreeDigitISOCode] char(3) -- collate Latin1_General_100_BIN2
, [CountryCurrency] char(5) -- collate Latin1_General_100_BIN2
, [IndexBasedCurrency] char(5) -- collate Latin1_General_100_BIN2
, [HardCurrency] char(5) -- collate Latin1_General_100_BIN2
, [TaxCalculationProcedure] nvarchar(6)
, [CountryAlternativeCode] nvarchar(3)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_Country] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Country]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
