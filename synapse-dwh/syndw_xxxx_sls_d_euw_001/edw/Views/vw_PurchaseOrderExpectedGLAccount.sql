CREATE VIEW [edw].[vw_PurchaseOrderExpectedGLAccount]
AS
SELECT
    RIGHT(                              -- add leading zeros to GLAccountID
        CONCAT(                         -- if they weren't added in file reference
            '0000000000'
            ,[GLAccountID]
        )
        ,10
    )                               AS [GLAccountID]
FROM base_ff.PurchaseOrderExpectedGLAccount