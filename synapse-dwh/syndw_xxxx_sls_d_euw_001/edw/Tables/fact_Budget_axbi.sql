CREATE TABLE [edw].[fact_Budget_axbi]
(
    [sk_fact_Budget]        BIGINT IDENTITY (1,1)                        NOT NULL,
    [nk_fact_Budget]        NVARCHAR(100)                                NOT NULL,
    [CurrencyTypeID]        CHAR(2)                                      NOT NULL,
    [CurrencyType]          NVARCHAR(20)                                 NOT NULL,
    [CurrencyID]            CHAR(5), -- collate Latin1_General_100_BIN2 NULL,
    [ExchangeRate]          DECIMAL(15, 6)                               NULL,
    [AccountingDate]        DATE                                         NULL,
    [SalesOrganizationID]   NVARCHAR(8)                                  NULL,
    [SoldToParty]           NVARCHAR(20)                                 NULL,
    [FinSales100]           DECIMAL(19, 6)                               NULL,
    [Year]                  CHAR(4), -- collate Latin1_General_100_BIN2 NULL,
    [Month]                 nvarchar(12), -- collate Latin1_General_100_BIN2 NULL,
    [YearMonth]             char(6), -- collate Latin1_General_100_BIN2 NULL,
    [axbi_DataAreaID]       NVARCHAR(8)                                  NULL,
    [axbi_DataAreaName]     NVARCHAR(50)                                 NULL,
    [axbi_DataAreaGroup]    NVARCHAR(8)                                  NULL,
    [axbi_MaterialID]       NVARCHAR(100)                                NULL,
    [axbi_CustomerID]       NVARCHAR(100)                                NULL,
    [MaterialCalculated]    NVARCHAR(80)                                 NULL,
    [SoldToPartyCalculated] NVARCHAR(20)                                 NULL,
    [InOutID]               NVARCHAR(6) collate Latin1_General_100_BIN2  NULL,
    [t_applicationId]       VARCHAR(32),
    [t_extractionDtm]       DATETIME,
    [t_jobId]               VARCHAR(36),
    [t_jobDtm]              DATETIME,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_fact_Budget_axbi] PRIMARY KEY NONCLUSTERED ([sk_fact_Budget]) NOT ENFORCED
) WITH
      (
      DISTRIBUTION = HASH ([nk_fact_Budget]), CLUSTERED COLUMNSTORE INDEX
)