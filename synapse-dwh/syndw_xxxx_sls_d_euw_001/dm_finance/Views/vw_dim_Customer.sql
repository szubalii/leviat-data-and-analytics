CREATE VIEW [dm_finance].[vw_dim_Customer] AS
WITH DummyRecords AS (
    SELECT CONCAT('(MA)-',[LowerBoundaryAccount])   AS DummyID
        ,[LowerBoundaryAccount]                     AS GLAccountID
    FROM edw.vw_FinancialStatementHierarchy
    WHERE FinancialStatementItem IN (
        SELECT FinancialStatementItem
        FROM edw.vw_FinancialStatementItem
        WHERE 
            ParentNode = '001005'               -- for DEV
            --ParentNode = '000570'             -- for PROD
    )
)
SELECT
  [CustomerID]
, [Customer]
, [CustomerID_Name]
, [CustomerAccountGroupID]
, [AccountGroup]
, [AuthorizationGroup] as AuthorizationGroupID
, null as AuthorizationGroup
, [DeliveryIsBlocked]
, [PostingIsBlocked]
, [BillingIsBlockedForCustomer]
, [OrderIsBlockedForCustomer]
, [IsOneTimeAccount]
, [CountryID]
, [Country]
, [CityName]
, [PostalCode]
, [StreetName]
, [RegionID]
, [Region]
, [DeletionIndicator]
, [TradingPartner] as TradingPartnerID
, null as TradingPartner
, [BusinessType]
, [IndustryType]
, [t_jobDtm]
, [t_applicationId]
, [t_extractionDtm]
FROM [edw].[dim_Customer]

UNION ALL

SELECT
  'MA-Dummy'        AS [CustomerID]
,d.[DummyID] COLLATE DATABASE_DEFAULT       AS [Customer]
,CONCAT(d.[DummyID] COLLATE DATABASE_DEFAULT
    ,'_'
    ,gla.[GLAccountLongName]
)                   AS [CustomerID_Name]
,null               AS [CustomerAccountGroupID]
,null               AS [AccountGroup]
,null               AS [AuthorizationGroupID]
,null               AS AuthorizationGroup
,null               AS [DeliveryIsBlocked]
,null               AS [PostingIsBlocked]
,null               AS [BillingIsBlockedForCustomer]
,null               AS [OrderIsBlockedForCustomer]
,null               AS [IsOneTimeAccount]
,null               AS [CountryID]
,null               AS [Country]
,gla.[GLAccountLongName]    AS CityName
,null               AS [PostalCode]
,null               AS [StreetName]
,null               AS [RegionID]
,null               AS [Region]
,null               AS [DeletionIndicator]
,null               AS [TradingPartnerID]
,null               AS [TradingPartner]
,null               AS [BusinessType]
,null               AS [IndustryType]
,null               AS [t_jobDtm]
,null               AS [t_applicationId]
,null               AS[t_extractionDtm]
FROM DummyRecords d
LEFT JOIN [dm_sales].[vw_dim_GLAccountText] gla
    ON d.GLAccountID = gla.GLAccount                COLLATE DATABASE_DEFAULT