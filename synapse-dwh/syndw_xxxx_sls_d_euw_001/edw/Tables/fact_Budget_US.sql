CREATE TABLE [edw].[fact_Budget_US]
(
        [sk_fact_Budget_US]                        BIGINT IDENTITY (1,1)                                NOT NULL
    ,   [nk_fact_Budget_US]                        NVARCHAR(100)                                        NOT NULL
    ,   [BillingDocumentDate]                      DATETIME                                             NULL
    ,   [SalesOrganizationID]                      NVARCHAR(24)                                         NULL
    ,   [NetAmount]                                DECIMAL(28,12)                                       NULL
    ,   [TransactionCurrencyID]                    CHAR(6) -- collate Latin1_General_100_BIN2
    ,   [CurrencyTypeID]                           CHAR(2)                                              NULL
    ,   [CurrencyType]                             NVARCHAR(20)                                         NULL
    ,   [CurrencyID]                               CHAR(3) -- collate Latin1_General_100_BIN2
    ,   [ExchangeRate]                             DECIMAL(15, 6)                                       NULL
    ,   [FinNetAmount]                             DECIMAL(28,12)                                       NULL
    ,   [AccountingDate]                           DATETIME                                             NULL
    ,   [MaterialCalculated]                       NVARCHAR(105)                                        NULL
    ,   [SalesOrgname]                             NVARCHAR(80)                                         NULL
    ,   [MaterialLongDescription]                  NVARCHAR(2000)                                       NULL
    ,   [MaterialShortDescription]                 NVARCHAR(2000)                                       NULL
    ,   [FinSales100]                              DECIMAL(19, 6)                                       NULL
    ,   [t_applicationId]                          VARCHAR(32)
    ,   [t_extractionDtm]                          DATETIME
    ,   [t_jobId]                                  VARCHAR(36)
    ,   [t_jobDtm]                                 DATETIME
    ,   [t_lastActionCd]                           VARCHAR(1)
    ,   [t_jobBy]                                  NVARCHAR(128)
    ,   CONSTRAINT [PK_fact_Budget_US] PRIMARY KEY NONCLUSTERED ([sk_fact_Budget_US]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = HASH ([nk_fact_Budget_US]),
    CLUSTERED COLUMNSTORE INDEX
)
GO