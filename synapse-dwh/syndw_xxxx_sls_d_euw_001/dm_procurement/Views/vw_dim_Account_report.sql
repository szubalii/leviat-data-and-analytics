CREATE VIEW [dm_procurement].[vw_dim_Account_report]
AS
SELECT
    AccountId
    ,CompanyCode
    ,REPLACE(AccountName,'"','')        AS AccountName
    ,MajorAccountId
    ,MajorAccountName
    ,ChartOfAccountsId
    ,ChartOfAccountsName
FROM [dm_procurement].[vw_dim_Account]