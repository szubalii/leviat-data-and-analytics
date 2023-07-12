CREATE TABLE [edw].[fact_ACDOCA_FinStatemnt]
(
    [CompanyCodeID]                         NVARCHAR(8),
    [ProfitCenterID]                        NVARCHAR(20),
    [ProfitCenter]                          NVARCHAR(40),
    [GLAccountID]                           NVARCHAR(20),
    [FunctionalAreaID]                      NVARCHAR(32),
    [CurrencyID]                            CHAR(5),
    [SAP_Sales]                             DECIMAL(23, 2),
    [SAP_COGS]                              DECIMAL(23, 2),
    [SAP_SalesMargin]                       DECIMAL(23, 2),
    [FiscalYear]                            CHAR(4),
    [FiscalYearPeriod]                      CHAR(7),
    [t_applicationId]                       VARCHAR(32),
    [t_extractionDtm]                       DATETIME,
    [t_jobId]                               VARCHAR(36),
    [t_jobDtm]                              DATETIME,
    [t_lastActionCd]                        VARCHAR(1),
    [t_jobBy]                               NVARCHAR(128)
)
    WITH
        (HEAP)
GO