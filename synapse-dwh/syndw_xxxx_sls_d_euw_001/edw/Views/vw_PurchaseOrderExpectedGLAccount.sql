CREATE VIEW [edw].[vw_PurchaseOrderExpectedGLAccount]
AS
SELECT
    RIGHT(
        CONCAT(
            '0000000000'
            ,[GLAccountID]
        )
        ,10
    )                               AS [GLAccountID]
FROM base_ff.PurchaseOrderExpectedGLAccount