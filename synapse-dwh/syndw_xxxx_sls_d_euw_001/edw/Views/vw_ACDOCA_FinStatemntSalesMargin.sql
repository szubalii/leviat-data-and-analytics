CREATE VIEW [edw].[vw_ACDOCA_FinStatemntSalesMargin]
	AS 
WITH L1 
AS (
    SELECT 
       [HierarchyNode]
      ,[NodeType]
      ,[FinancialStatementItem]
      ,[ParentNode]
      ,[ChildNode]
      ,[SiblingNode]
      ,[FinStatementHierarchyLevelVal]
      ,[FinStatementItemDescription]
    FROM [edw].[dim_FinancialStatementItem]
    --Sales Margin
    WHERE FinancialStatementItem IN ('9')
),
L2 
AS (
    SELECT 
      FSI.[HierarchyNode]
      ,FSI.[NodeType]
      ,FSI.[FinancialStatementItem]
      ,FSI.[ParentNode]
      ,FSI.[ChildNode]
      ,FSI.[SiblingNode]
      ,FSI.[FinStatementHierarchyLevelVal]
      ,FSI.[FinStatementItemDescription]
      ,L1.[FinancialStatementItem] AS Level1
      ,L1.[FinStatementItemDescription] AS L1Description
    FROM [edw].[dim_FinancialStatementItem] FSI
    INNER JOIN L1 
        ON FSI.ParentNode = L1.HierarchyNode
),
L3 
AS  (
    SELECT
      FSI.[HierarchyNode]
      ,FSI.[NodeType]
      ,FSI.[FinancialStatementItem]
      ,FSH.LowerBoundaryAccount
      ,FSH.UpperBoundaryAccount
      ,FSI.[ParentNode]
      ,FSI.[ChildNode]
      ,FSI.[SiblingNode]
      ,FSI.[FinStatementHierarchyLevelVal]
      ,FSI.[FinStatementItemDescription]
      ,L2.Level1
      ,L2.L1Description
      ,L2.[FinancialStatementItem] AS Level2
      ,L2.[FinStatementItemDescription] AS L2Description
    FROM [edw].[dim_FinancialStatementItem] FSI
    INNER JOIN L2 
        ON FSI.ParentNode = L2.HierarchyNode
    LEFT JOIN [edw].[dim_FinancialStatementHierarchy] FSH
        ON FSI.FinancialStatementItem = FSH.FinancialStatementItem
),
Accs 
AS (
    SELECT 
        AC.CompanyCodeID
        ,AC.ProfitCenterID
        ,PC.ProfitCenter
        ,AC.GLAccountID
        ,AC.FunctionalAreaID
        ,AC.CompanyCodeCurrency
        ,L3.Level2                  AS Level2
        ,CASE 
            WHEN Level2 like '12' 
                THEN AC.[AmountInCompanyCodeCurrency]
            ELSE NULL
        END                         AS PL_Sales
        ,CASE 
            WHEN Level2 like '13'  
                THEN AC.[AmountInCompanyCodeCurrency] 
            ELSE NULL
        END                         AS PL_COGS
        ,AC.FiscalYear              AS FY
        ,AC.FiscalYearPeriod        AS FPeriod
        ,CASE ZED.Contingency5
            WHEN 'Sales'
            THEN -1 * AC.[AmountInCompanyCodeCurrency]
            ELSE null
        END AS [SalesAmount],
        CASE ZED.Contingency5
            WHEN 'COGS'
            THEN -1 * AC.[AmountInCompanyCodeCurrency]
            ELSE null
        END AS [COGSActCostAmount],
        CASE 
            WHEN ZED.Contingency5 = 'COGS' AND AC.[AccountingDocumentTypeID] <> 'ML'
            THEN -1 * AC.[AmountInCompanyCodeCurrency]
            ELSE null
        END AS [COGSStdCostAmount],
        CASE ZED.Contingency5
            WHEN 'Other CoS'
            THEN -1 * AC.[AmountInCompanyCodeCurrency]
            ELSE null
        END AS [OtherCoSAmount],
        CASE ZED.Contingency5
            WHEN 'Opex'
            THEN -1 * AC.[AmountInCompanyCodeCurrency]
            ELSE null
        END AS [OpexAmount],
        CASE ZED.Contingency4
            WHEN 'Gross Margin'
            THEN -1 * AC.[AmountInCompanyCodeCurrency]
            ELSE null
        END AS [GrossMarginAmount],
        CASE
            WHEN ZED.Contingency5 = 'COGS'
            THEN 'COGSAct'
            WHEN ZED.Contingency5 = 'COGS' AND AC.[AccountingDocumentTypeID] <> 'ML'    --it's unreachable code at the moment, reserved for future needs
            THEN 'COGSStd'
            ELSE ZED.Contingency5
        END AS [AmountCategory]
        ,AC.t_applicationId
        ,AC.t_extractionDtm
    FROM [edw].[fact_ACDOCA] AC
    INNER JOIN L3 
        ON AC.GLAccountID COLLATE Latin1_General_CI_AS BETWEEN L3.LowerBoundaryAccount AND L3.UpperBoundaryAccount 
    INNER JOIN [edw].[dim_ZE_EXQLMAP_DT] ZED
        ON AC.[GLAccountID] = ZED.[GLAccountID]
            AND AC.[FunctionalAreaID] = ZED.[FunctionalAreaID]
    LEFT JOIN [dm_finance].vw_dim_ProfitCenter PC
        ON AC.[ProfitCenterID]= PC.ProfitCenterID
    WHERE 
        AC.[SourceLedgerID] IN ('0L','OC')
)
SELECT
     CompanyCodeID
    ,ProfitCenterID
    ,ProfitCenter    
    ,GLAccountID
    ,FunctionalAreaID
    ,CompanyCodeCurrency AS CurrencyID
    ,sum(PL_Sales) AS SAP_Sales
    ,sum(PL_COGS) AS SAP_COGS
    ,sum(COALESCE([PL_Sales],0) + COALESCE([PL_COGS],0)) AS SAP_SalesMargin
    ,FY AS FiscalYear
    ,FPeriod AS FiscalYearPeriod
    ,t_applicationId
    ,t_extractionDtm
FROM Accs
GROUP BY
     CompanyCodeID
    ,ProfitCenterID
    ,ProfitCenter
    ,GLAccountID
    ,FunctionalAreaID
    ,CompanyCodeCurrency
    ,FY
    ,FPeriod
    ,t_applicationId
    ,t_extractionDtm