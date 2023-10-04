CREATE TABLE [edw].[dim_ExchangeRateType]
(
    [ExchangeRateTypeID]             NVARCHAR(4) NOT NULL,
    [ExchangeRateType]               nvarchar(40),
    [ReferenceCurrency]              char(5), -- collate Latin1_General_100_BIN2,
    [BuyingRateAvgExchangeRateType]  nvarchar(4),
    [InvertedExchangeRateIsAllowed]  nvarchar(1),
    [SellingRateAvgExchangeRateType] nvarchar(4),
    [FixedExchangeRateIsUsed]        nvarchar(1),
    [SpecialConversionIsUsed]        nvarchar(1),
    [SourceCurrencyIsBaseCurrency]   nvarchar(1),
    [t_applicationId]               VARCHAR(32)    NULL,
    [t_jobId]                       VARCHAR(36)    NULL,
    [t_jobDtm]                      DATETIME       NULL,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
        CONSTRAINT [PK_dim_ExchangeRateType] PRIMARY KEY NONCLUSTERED ([ExchangeRateTypeID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO