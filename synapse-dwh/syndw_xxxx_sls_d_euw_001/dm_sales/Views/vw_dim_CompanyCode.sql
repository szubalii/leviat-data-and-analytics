CREATE VIEW [dm_sales].[vw_dim_CompanyCode] AS 

SELECT
  [CompanyCodeID]
, [CompanyCode]
, [CityName]
, [Country]
, [Currency]
, [ChartOfAccounts]
, [Company]
, [CashDiscountBaseAmtIsNetAmt]
, [t_jobDtm]
FROM [edw].[dim_CompanyCode]
