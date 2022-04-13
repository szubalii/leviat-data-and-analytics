CREATE VIEW [dm_sales].[vw_dim_Customer] AS

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
