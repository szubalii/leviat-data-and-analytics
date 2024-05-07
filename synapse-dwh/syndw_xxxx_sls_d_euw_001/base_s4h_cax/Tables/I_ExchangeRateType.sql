CREATE TABLE [base_s4h_cax].[I_ExchangeRateType](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ExchangeRateType] nvarchar(4) NOT NULL
, [ReferenceCurrency] char(5) -- collate Latin1_General_100_BIN2
, [BuyingRateAvgExchangeRateType] nvarchar(4)
, [InvertedExchangeRateIsAllowed] nvarchar(1)
, [SellingRateAvgExchangeRateType] nvarchar(4)
, [FixedExchangeRateIsUsed] nvarchar(1)
, [SpecialConversionIsUsed] nvarchar(1)
, [SourceCurrencyIsBaseCurrency] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ExchangeRateType] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ExchangeRateType]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
