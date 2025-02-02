CREATE VIEW [dm_global].[vw_dim_GLAccount]
AS
SELECT
    at.ChartOfAccounts,
    at.GLAccountID,
    at.GLAccount,
    at.GLAccountLongName,
    at.LastChangeDateTime,
    CASE
        WHEN gla.GLAccountID IS NOT NULL
            THEN    1
        ELSE        0
    END                             AS IsPurchaseOrderExpected,
    at.t_applicationId,
    at.t_extractionDtm
FROM [edw].[vw_GLAccountText]        at
LEFT JOIN [edw].[vw_PurchaseOrderExpectedGLAccount]     gla
    ON at.GLAccountID = gla.GLAccountID   