CREATE VIEW [edw].[vw_ACDOCA_DummyRecords] AS
SELECT CONCAT('(MA)-',[LowerBoundaryAccount])   AS DummyID
    ,[LowerBoundaryAccount]                     AS GLAccountID
FROM edw.vw_FinancialStatementHierarchy
WHERE FinancialStatementItem IN (
    SELECT FinancialStatementItem
    FROM edw.vw_FinancialStatementItem
    WHERE 
        ParentNode = '$(EXQL_Sales_Node)'
)