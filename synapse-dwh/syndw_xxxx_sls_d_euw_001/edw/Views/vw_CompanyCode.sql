CREATE VIEW [edw].[vw_CompanyCode]
AS
SELECT 
	 [CompanyCode] AS [CompanyCodeID]
    ,[CompanyCodeName] AS [CompanyCode]
    ,[CityName]
    ,[Country]
    ,[Currency]
    ,[Language]
    ,[ChartOfAccounts]
    ,[FiscalYearVariant]
    ,[Company]
    ,[CreditControlArea]
    ,[CountryChartOfAccounts]
    ,[FinancialManagementArea]
    ,[AddressID]
    ,[TaxableEntity]
    ,[VATRegistration]
    ,[ExtendedWhldgTaxIsActive]
    ,[ControllingArea]
    ,[FieldStatusVariant]
    ,[NonTaxableTransactionTaxCode]
    ,[DocDateIsUsedForTaxDetn]
    ,[TaxRptgDateIsActive]
    ,CR.[RegionID]
    ,CR.[RegionName]
    ,[DescriptionReporting]
    ,ICC.[t_applicationId]
FROM 
    [base_s4h_cax].[I_CompanyCode] ICC
LEFT JOIN  
    [base_ff].[CountryRegion] CR
    ON  ICC.Country=CR.CountryID
LEFT JOIN 
    [base_ff].[CompanyCode] CC
    ON 
   
-- WHERE 
    -- MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
