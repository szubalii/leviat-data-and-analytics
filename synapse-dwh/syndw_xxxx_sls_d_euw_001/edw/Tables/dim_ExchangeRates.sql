CREATE TABLE [edw].[dim_ExchangeRates] (
-- Exchange Rate
  [ExchangeRateType] nvarchar(8) NOT NULL
, [SourceCurrency] char(5) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [TargetCurrency] char(5) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ExchangeRateEffectiveDate] date NOT NULL
, [ExchangeRate] numeric(15,6)
, [NumberOfSourceCurrencyUnits] decimal(9)
, [NumberOfTargetCurrencyUnits] decimal(9)
, [AlternativeExchangeRateType] nvarchar(8)
, [AltvExchangeRateTypeValdtyDate] date
, [InvertedExchangeRateIsAllowed] nvarchar(2)
, [ReferenceCurrency] char(5) -- collate Latin1_General_100_BIN2
, [BuyingRateAvgExchangeRateType] nvarchar(8)
, [SellingRateAvgExchangeRateType] nvarchar(8)
, [FixedExchangeRateIsUsed] nvarchar(2)
, [SpecialConversionIsUsed] nvarchar(2)
, [SourceCurrencyDecimals] tinyint
, [TargetCurrencyDecimals] tinyint
, [ExchRateIsIndirectQuotation] nvarchar(2)
, [AbsoluteExchangeRate] decimal(9,5)
, [EffectiveExchangeRate] decimal(12,5)
, [DirectQuotedEffectiveExchRate] decimal(9,5)
, [IndirectQuotedEffctvExchRate] decimal(9,5)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
,    CONSTRAINT [PK_dim_ExchangeRates] PRIMARY KEY NONCLUSTERED ([ExchangeRateType],[SourceCurrency],[TargetCurrency],[ExchangeRateEffectiveDate]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = HASH ([ExchangeRateType]),
    CLUSTERED COLUMNSTORE INDEX
)
GO
