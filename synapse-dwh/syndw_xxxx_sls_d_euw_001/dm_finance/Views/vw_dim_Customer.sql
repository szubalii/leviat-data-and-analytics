CREATE VIEW [dm_finance].[vw_dim_Customer] AS
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
d.[DummyID]         AS [CustomerID]
,d.[DummyName]      AS [Customer]
,d.[DummyIDName]    AS [CustomerID_Name]
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
,'Manual Adjustment'    AS [Country]
,d.[DummyName]      AS [CityName]
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
FROM [edw].[vw_ACDOCA_DummyRecords] d