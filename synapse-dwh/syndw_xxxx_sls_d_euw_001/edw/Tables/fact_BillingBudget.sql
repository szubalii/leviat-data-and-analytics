-- This table is obsolete. Separate budget tables exist now:
-- [edw].[fact_Budget_US]
-- [edw].[fact_Budget_axbi]
CREATE TABLE [edw].[fact_BillingBudget]
(
    [BillingDocument]       NVARCHAR(20)                                 NOT NULL,
    [BillingDocumentItem]   CHAR(7) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [CurrencyTypeID]        CHAR(2)                                      NOT NULL,
    [CurrencyType]          NVARCHAR(20)                                 NOT NULL,
    [CurrencyID]            CHAR(5), -- collate Latin1_General_100_BIN2 NULL,
    [ExchangeRate]          DECIMAL(15, 6)                               NULL,
    [BillingDocumentDate]   DATE                                         NULL,
    [SalesOrganizationID]   NVARCHAR(8)                                  NULL,
    [Material]              NVARCHAR(80)                                 NULL,
    [CountryID]             NVARCHAR(6)                                  NULL,
    [SoldToParty]           NVARCHAR(20)                                 NULL,
    [FinSales100]           DECIMAL(19, 6)                               NULL,
    [AccountingDate]        DATETIME                                     NULL,
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
    [InOutID]               CHAR(1), -- collate Latin1_General_100_BIN2 NULL,
    [t_applicationId]       VARCHAR(32),
    [t_extractionDtm]       DATETIME,
    [t_jobId]               VARCHAR(36),
    [t_jobDtm]              DATETIME,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_fact_BillingBudget] PRIMARY KEY NONCLUSTERED ([BillingDocument], [BillingDocumentItem], [CurrencyTypeID]) NOT ENFORCED
) WITH
      (
      DISTRIBUTION = HASH (BillingDocument), CLUSTERED COLUMNSTORE INDEX
)