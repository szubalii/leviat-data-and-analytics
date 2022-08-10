CREATE VIEW [dm_sales].[vw_dim_FinancialStatementHierarchy] AS
SELECT
       [FinancialStatementVariant],
       [FinancialStatementItem],
       [ChartOfAccounts],
       [LowerBoundaryAccount],
       [LowerBoundaryFunctionalArea],
       [UpperBoundaryAccount],
       [UpperBoundaryFunctionalArea],
       [IsDebitBalanceRelevant],
       [t_extractionDtm],
       [t_applicationId]
FROM
     [edw].[dim_FinancialStatementHierarchy]
