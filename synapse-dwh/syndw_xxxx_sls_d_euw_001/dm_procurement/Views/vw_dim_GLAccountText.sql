CREATE VIEW [dm_procurement].[vw_dim_GLAccountText]
AS
SELECT
    at.ChartOfAccounts,
    at.GLAccountID,
    at.GLAccount,
    at.GLAccountLongName,
    at.LastChangeDateTime,
    CASE
        WHEN gla.GLAccountID IS NOT NULL
            THEN 'Y'
    END                             AS ExpectedPO
    at.t_applicationId,
    at.t_extractionDtm
FROM [edw].[vw_GLAccountText]        at
LEFT JOIN [edw].[vw_POGLAccount]     gla
    ON at.GLAccountID = gla.GLAccountID   