CREATE VIEW [dm_sales].[vw_dim_GLAccountText]
    AS SELECT
        ChartOfAccounts,
        GLAccount,
        GLAccountName,
        GLAccountLongName,
        LastChangeDateTime,
        t_applicationId,
        t_extractionDtm
    FROM [base_s4h_cax].[I_GLAccountText]
    WHERE [Language] = 'E'        