CREATE TABLE [edw].[fact_ACDOCA_FinStatemntSalesMargin]
(
    [CompanyCodeID]                         NVARCHAR(8)     NOT NULL,
    [ProfitCenterID]                        NVARCHAR(20)    NOT NULL,
    [ProfitCenter]                          NVARCHAR(40),
    [GLAccountID]                           NVARCHAR(20)    NOT NULL,
    [FunctionalAreaID]                      NVARCHAR(32)    NOT NULL,
    [CurrencyID]                            CHAR(5)         NOT NULL,
    [SAP_Sales]                             DECIMAL(23, 2),
    [SAP_COGS]                              DECIMAL(23, 2),
    [SAP_SalesMargin]                       DECIMAL(23, 2),
    [FiscalYear]                            CHAR(4),
    [FiscalYearPeriod]                      CHAR(7)         NOT NULL,
    [t_applicationId]                       VARCHAR(32),
    [t_extractionDtm]                       DATETIME,
    [t_jobId]                               VARCHAR(36),
    [t_jobDtm]                              DATETIME,
    [t_lastActionCd]                        VARCHAR(1),
    [t_jobBy]                               NVARCHAR(128),
    CONSTRAINT [PK_fact_ACDOCA_FinStatemntSalesMargin] PRIMARY KEY NONCLUSTERED
    ([CompanyCodeID],
     [ProfitCenterID],
     [GLAccountID],
     [FunctionalAreaID],
     [CurrencyID],
     [FiscalYearPeriod]
    ) NOT ENFORCED
)
    WITH
        (DISTRIBUTION = HASH ([GLAccountID]), CLUSTERED COLUMNSTORE INDEX)
GO