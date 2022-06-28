CREATE VIEW [dq].[vw_Totals]
	AS  

    SELECT
        [RuleID]
        , [Product] 
    FROM
        [dq].[vw_Product_1_2]

    UNION ALL

    SELECT
        [RuleID]
        , [Product]  
    FROM
        [dq].[vw_Product_1_8]

    UNION ALL

    SELECT
        [RuleID]
        , [Product]    
    FROM
        [dq].[vw_Product_1_16]

    UNION ALL

    SELECT
        [RuleID]
        , [Product]   
    FROM
        [dq].[vw_Product_1_17]

    UNION ALL

    SELECT
        [RuleID]
        , [Product]    
    FROM
        [dq].[vw_Product_1_18]

    UNION ALL

    SELECT
        [RuleID]
        , [Product] 
    FROM
        [dq].[vw_Product_1_19]

    UNION ALL

    SELECT
        [RuleID]
        , [Product]   
    FROM
        [dq].[vw_Product_1_20]
 
