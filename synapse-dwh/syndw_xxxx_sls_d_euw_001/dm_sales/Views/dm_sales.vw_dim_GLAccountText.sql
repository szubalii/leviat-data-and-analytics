CREATE VIEW [dm_sales].[vw_dim_GLAccountText]
    AS SELECT
        ChartOfAccounts,
        GLAccountID,
        GLAccount,
        GLAccountLongName,
        LastChangeDateTime,
        t_applicationId,
        t_extractionDtm
    FROM [edw].[vw_GLAccountText]