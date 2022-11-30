CREATE VIEW [edw].[vw_ACDOCA_DummyRecords] AS
SELECT CONCAT('(MA)-',fsh.[LowerBoundaryAccount] COLLATE DATABASE_DEFAULT)   AS DummyID
    --,fsh.[LowerBoundaryAccount]                     COLLATE DATABASE_DEFAULT AS GLAccountID
    ,gla.[GLAccountLongName]                                                 AS DummyName
    ,CONCAT('(MA)-'
        ,fsh.[LowerBoundaryAccount] COLLATE DATABASE_DEFAULT
        ,'_'
        ,gla.[GLAccountLongName]
    )                                               COLLATE DATABASE_DEFAULT AS DummyIDName
FROM edw.dim_FinancialStatementHierarchy    fsh
LEFT JOIN [edw].[vw_GLAccountText]          gla
    ON fsh.LowerBoundaryAccount = gla.GLAccount                COLLATE DATABASE_DEFAULT
WHERE fsh.FinancialStatementItem IN (
    SELECT FinancialStatementItem
    FROM edw.dim_FinancialStatementItem
    WHERE 
        ParentNode = '$(EXQL_Sales_Node)'
)