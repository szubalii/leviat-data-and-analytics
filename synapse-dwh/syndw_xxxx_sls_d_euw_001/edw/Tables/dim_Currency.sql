CREATE TABLE [edw].[dim_Currency]
(
    [CurrencyID]                  CHAR(5) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [Currency]                    NVARCHAR(80) NULL,
    [Decimals]                    TINYINT      NULL,
    [CurrencyISOCode]             NVARCHAR(6)  NULL,
    [AlternativeCurrencyKey]      NVARCHAR(6)  NULL,
    [IsPrimaryCurrencyForISOCrcy] NVARCHAR(2)  NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
,    CONSTRAINT [PK_dim_Currency] PRIMARY KEY NONCLUSTERED ([CurrencyID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO