CREATE VIEW [edw].[vw_FinancialStatementItem]
    AS
    SELECT
        icns.[FinancialStatementVariant],
        icns.[FinancialStatementItem],
        icns.[HierarchyNode],
        icns.[NodeType],
        icns.[ParentNode],
        icns.[ChildNode],
        icns.[SiblingNode],
        icns.[FinStatementHierarchyLevelVal],
        -- icns.[SignIsInverted],
        icns.[LastChangeDate],
    --I_FinancialStatementItemText      
        ifsix.[FinStatementItemDescription], 
        icns.[t_applicationId],
        icns.[t_extractionDtm]                     
    FROM  
        [base_s4h_cax].[I_CN_CADEFinancialStatementItm] icns 
    LEFT JOIN 
        [base_s4h_cax].[I_FinancialStatementItemText] ifsix 
        ON 
            ifsix.[FinancialStatementVariant] = icns.[FinancialStatementVariant]
            AND
            ifsix.[FinancialStatementItem] =  icns.[FinancialStatementItem] 
            AND 
            ifsix.[Language] = 'E'
    WHERE icns.FinancialStatementVariant = 'EXQL'                     