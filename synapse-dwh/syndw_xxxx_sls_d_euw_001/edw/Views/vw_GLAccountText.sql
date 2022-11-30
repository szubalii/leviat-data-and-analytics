CREATE VIEW [edw].[vw_GLAccountText]
    AS SELECT
        ChartOfAccounts,
        GLAccount as GLAccountID,
        GLAccountName as GLAccount,
        GLAccountLongName,
        LastChangeDateTime,
        t_applicationId,
        t_extractionDtm
    FROM [base_s4h_cax].[I_GLAccountText]
    WHERE [Language] = 'E'        
    AND ChartOfAccounts = 'SCOA'