-- created on 11/10/2022  by Zhaniya A. 
-- last modifyed on 12/10/22 
-- this view is need to create a Suppliers List Report and contains only Dim tables 

CREATE VIEW dm_sales.vw_dim_SuppliersList AS
WITH 
Supplier AS (
	SELECT 
			s.[SupplierID] AS [SupplierID_init]
		,	SUBSTRING(s.SupplierID, PATINDEX('%[^0]%', s.SupplierID+'.'), LEN(s.SupplierID)) AS [SupplierID] -- Remove leading zeros
		,	s.[Supplier] AS [SupplierName]
		,	CONCAT(SUBSTRING(s.SupplierID, PATINDEX('%[^0]%', s.SupplierID+'.'), LEN(s.SupplierID)), ' (', s.[Supplier], ')') AS [SupplierID_Name] -- Remove leading zeros and concantenate string
		,	s.[SupplierAccountGroupID] 
		,	s.[AccountGroup]
		,	CONCAT(s.[SupplierAccountGroupID], ' (', s.[AccountGroup], ')') AS [SupplierAccGroupID_Name]
		,	s.[CreatedByUser]
		,	CASE 
				WHEN ISNULL(TRIM(s.[PostingIsBlocked]), '') = '' --is null OR s.[PostingIsBlocked] = ''
				THEN 'false' 
				ELSE s.[PostingIsBlocked]
			END AS [PostingIsBlocked]
		,	s.[CountryID]
		,	s.[Country]
		,	CONCAT(s.[CountryID], ' (', s.[Country], ')') AS [CountryID_Name]
		,	s.[CityName]
		,	s.[PostalCode]
		,	s.[StreetName]
		,	CASE 
				WHEN ISNULL(TRIM(s.[DeletionIndicator]), '') = ''
				THEN 'false' 
				ELSE s.[DeletionIndicator]
			END AS [DeletionIndicator]
		,	s.[t_applicationId]
		,	s.[t_extractionDtm]
	FROM [dm_sales].[vw_dim_Supplier] s
)
,
Company AS
(
	SELECT 
			c.[SupplierID] as [SupplierID_init]
		,	c.[CompanyCodeID]
		,	c.[PaymentMethodsList]
		--,	c.[t_applicationId]
		--,	c.[t_extractionDtm] 
	FROM [dm_sales].[vw_dim_SupplierCompany] c
)
,
BankDetails AS
(
	SELECT 
			d.[SupplierID] AS [SupplierID_init]
		,	d.[BankCountryID]
		,	d.[Bank]
		,	d.[BankAccountID]
		,	d.[BankAccount]
		--,	d.[t_applicationId]
		--,	d.[t_extractionDtm] 	
	FROM [dm_sales].[vw_dim_SupplierBankDetails] d
)
,
PurchasingOrg AS
(
	SELECT 
			o.[SupplierID] AS [SupplierID_init]
		,	o.[PurchasingOrganizationID]
		,	o.[PurchasingOrganization]
		,	CONCAT(o.[PurchasingOrganizationID], ' (', o.[PurchasingOrganization], ')') AS [PurchasingOrgID_Name]
		,	o.[PurchasingGroupID]
		,	o.[PurchasingGroup]
		,	CONCAT(o.[PurchasingGroupID], ' (', o.[PurchasingGroup], ')') AS [PurchasingGroupID_Name]
		--,	o.[t_applicationId]
		--,	o.[t_extractionDtm] 
	FROM [dm_sales].[vw_dim_SupplierPurchasingOrg] o		
)
	SELECT  
	--Supplier's fields
			s.[SupplierID]
		,	s.[SupplierName]
		,	s.[SupplierID_Name]
		,	s.[SupplierAccountGroupID]
		,	s.[AccountGroup]
		,	s.[SupplierAccGroupID_Name]
		,	s.[CreatedByUser]
		,	s.[PostingIsBlocked]
		,	s.[CountryID]
		,	s.[Country]
		,	s.[CountryID_Name]
		,	s.[CityName]
		,	s.[PostalCode]
		,	s.[StreetName]
		,	s.[DeletionIndicator]
		,	s.[t_applicationId]
		,	s.[t_extractionDtm]

	-- Supplier's Company fields
		,	c.[CompanyCodeID]
		,	c.[PaymentMethodsList]

	-- Supplier's Bank Details fields
		,	d.[BankCountryID]
		,	d.[Bank]
		,	d.[BankAccountID]
		,	d.[BankAccount]
	-- Supplier's Purchasing Organization fields
		,	o.[PurchasingOrganizationID]
		,	o.[PurchasingOrganization]
		,	o.[PurchasingOrgID_Name]
		,	o.[PurchasingGroupID]
		,	o.[PurchasingGroup]
		,	o.[PurchasingGroupID_Name]
	FROM Supplier AS s
	LEFT JOIN Company AS c
		ON s.[SupplierID_init] /*COLLATE SQL_Latin1_General_CP1_CI_AS */ = c.[SupplierID_init]
	LEFT JOIN BankDetails AS d
		ON s.[SupplierID_init] /*COLLATE SQL_Latin1_General_CP1_CI_AS */ = d.[SupplierID_init]
	LEFT JOIN PurchasingOrg AS o
		ON s.[SupplierID_init] /*COLLATE SQL_Latin1_General_CP1_CI_AS */ = o.[SupplierID_init]

