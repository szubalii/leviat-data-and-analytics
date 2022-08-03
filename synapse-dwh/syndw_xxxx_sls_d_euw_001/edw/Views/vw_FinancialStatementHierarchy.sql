CREATE VIEW [edw].[vw_FinancialStatementHierarchy]
	AS
    SELECT 
        icn.[FinancialStatementVariant],
        icn.[FinancialStatementItem],
        icn.[ChartOfAccounts],
        icn.[LowerBoundaryAccount],
        icn.[LowerBoundaryFunctionalArea],
        icn.[UpperBoundaryAccount],
        icn.[UpperBoundaryFunctionalArea],
        icn.[IsDebitBalanceRelevant],
        icn.[IsCreditBalanceRelevant],
    --I_FinancialStatementItemText  
        ifsix.[FinStatementItemDescription]   
    FROM 
        [base_s4h_cax].[I_CN_CADEFinStatementLeafItem] icn 
    LEFT JOIN 
        [base_s4h_cax].[I_FinancialStatementItemText] ifsix 
        ON 
            ifsix.[FinancialStatementVariant] = icn.[FinancialStatementVariant]
            AND
            ifsix.[FinancialStatementItem] =  icn.[FinancialStatementItem] 
            AND 
            ifsix.[Language] = 'E'