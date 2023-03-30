CREATE VIEW [edw].[vw_ACDOCA_DummyRecords] AS
SELECT 
    distinct CONCAT('(MA)-',igla.[GLAccount]) AS DummyID
    ,gla.[GLAccountLongName]                  AS DummyName
    ,CONCAT('(MA)-'
            ,igla.[GLAccount]
            ,gla.[GLAccountLongName]
    )                COLLATE DATABASE_DEFAULT AS DummyIDName
FROM [base_s4h_cax].[I_GLAccount]    igla
LEFT JOIN [edw].[vw_GLAccountText]   gla
    ON igla.GLAccount = gla.GLAccountID            COLLATE DATABASE_DEFAULT
WHERE igla.ChartOfAccounts = 'SCOA'




