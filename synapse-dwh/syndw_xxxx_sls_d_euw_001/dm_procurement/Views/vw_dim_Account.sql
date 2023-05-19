CREATE VIEW [dm_procurement].[vw_dim_Account]
AS
SELECT
    PDI.GLAccountID                     AS AccountId
    ,PDI.CompanyCodeID                  AS CompanyCode
    ,Acc.GLAccountLongName              AS AccountName
    ,''                                 AS MajorAccountId
    ,''                                 AS MajorAccountName
    ,''                                 AS ChartOfAccountsId
    ,''                                 AS ChartOfAccountsName
FROM [edw].[fact_PurchasingDocumentItem]    PDI
LEFT JOIN
    [edw].[vw_GLAccountText]                Acc
    ON PDI.GLAccountID = Acc.GLAccountID    COLLATE DATABASE_DEFAULT
GROUP BY PDI.GLAccountID                     
        ,PDI.CompanyCodeID                  
        ,Acc.GLAccountLongName              