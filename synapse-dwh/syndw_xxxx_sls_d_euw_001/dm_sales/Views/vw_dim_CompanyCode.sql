CREATE VIEW [dm_sales].[vw_dim_CompanyCode]
AS 
SELECT
  CC.[CompanyCodeID]
, CC.[CompanyCode]
, CC.[CompanyCodeDescription]
, CC.[CityName]
, CC.[Country]
, Ctr.[Country]         AS CountryName
, CC.[Currency]
, CC.[ChartOfAccounts]
, CC.[Company]
, CC.[CashDiscountBaseAmtIsNetAmt]
, CC.[RegionID]         AS RegionID
, Rgn.[RegionName]      AS Region
, CC.[t_jobDtm]
FROM [edw].[dim_CompanyCode]    CC
LEFT JOIN [edw].[dim_Country]   Ctr
    ON CC.Country = Ctr.CountryID
LEFT JOIN base_ff.Region  Rgn
    ON CC.RegionID = Rgn.RegionID