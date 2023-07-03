CREATE VIEW [dm_sales].[vw_dim_CompanyCode]
AS 
WITH Regions AS (
    SELECT 
        RegionID,    
        RegionName,
        CountryID
    FROM [map_AXBI].[SalesOrganization]
    GROUP BY
        RegionID,    
        RegionName,
        CountryID
)
SELECT
  CC.[CompanyCodeID]
, CC.[CompanyCode]
, CC.[CityName]
, CC.[Country]
, Ctr.[Country]         AS CountryName
, CC.[Currency]
, CC.[ChartOfAccounts]
, CC.[Company]
, CC.[CashDiscountBaseAmtIsNetAmt]
, SO.[RegionID]         AS RegionID
, SO.[RegionName]       AS Region
, CC.[t_jobDtm]
FROM [edw].[dim_CompanyCode]    CC
LEFT JOIN [edw].[dim_Country]   Ctr
    ON CC.Country = Ctr.CountryID
LEFT JOIN Regions               SO
    ON CC.Country = SO.CountryID
