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
, case
            when CustomerID like 'IP%'             then 'IC_Lev'
            when CustomerID like 'IC__35%'         then 'IC_Lev'
            when CustomerID like 'IC__[^3][^5]%'   then 'IC_CRH'
            when CustomerID not like 'IP%' 
            and  CustomerID not like 'IC%'         then 'OC'
            else CustomerID
  end as InOutID
, [t_jobDtm]
, [t_applicationId]
, [t_extractionDtm]
FROM [edw].[dim_Customer]
