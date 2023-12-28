CREATE TABLE [base_s4h_cax].[I_ExchangeRate](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ExchangeRateType] nvarchar(4) NOT NULL
, [SourceCurrency] char(5) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [TargetCurrency] char(5) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ExchangeRateEffectiveDate] date NOT NULL
, [ExchangeRate] decimal(9,5)
, [NumberOfSourceCurrencyUnits] decimal(9)
, [NumberOfTargetCurrencyUnits] decimal(9)
, [AlternativeExchangeRateType] nvarchar(4)
, [AltvExchangeRateTypeValdtyDate] date
, [InvertedExchangeRateIsAllowed] nvarchar(1)
, [ReferenceCurrency] char(5) -- collate Latin1_General_100_BIN2
, [BuyingRateAvgExchangeRateType] nvarchar(4)
, [SellingRateAvgExchangeRateType] nvarchar(4)
, [FixedExchangeRateIsUsed] nvarchar(1)
, [SpecialConversionIsUsed] nvarchar(1)
, [SourceCurrencyDecimals] tinyint
, [TargetCurrencyDecimals] tinyint
, [ExchRateIsIndirectQuotation] nvarchar(1)
, [AbsoluteExchangeRate] decimal(9,5)
, [EffectiveExchangeRate] decimal(12,5)
, [DirectQuotedEffectiveExchRate] decimal(9,5)
, [IndirectQuotedEffctvExchRate] decimal(9,5)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ExchangeRate] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ExchangeRateType], [SourceCurrency], [TargetCurrency], [ExchangeRateEffectiveDate]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
