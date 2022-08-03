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
       [t_jobDtm],
       [t_applicationId]
FROM
     [edw].[fact_FinancialStatementHierarchy]
