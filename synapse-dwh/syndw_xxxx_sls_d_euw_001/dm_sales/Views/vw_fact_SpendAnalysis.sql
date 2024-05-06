-- created on 18/10/2022  by Zhaniya A. 
-- last modified 20/10/22 
-- this view was created with the purpose of developing Spend Analysis Report

CREATE VIEW [dm_sales].[vw_fact_SpendAnalysis] AS 
WITH 
SupplierInvoice AS (
	SELECT 
		-- [dm_sales].[vw_fact_SupplierInvoiceItemPurOrdRef] as ref
			ref.[sk_fact_PurchasingDocumentItem]
		-- [dm_sales].[vw_fact_SupplierInvoice] as inv
		,	inv.[InvoicingPartyID]
		,	inv.[DocumentDate] as [InvoiceDocumentDate]
		--,	inv.[CreationDate]
		,	inv.[PostingDate]
		,	inv.[InvoiceGrossAmount]
		,	inv.[SupplierInvoiceID] 
	FROM [edw].[fact_SupplierInvoiceItemPurOrdRef] ref
	LEFT JOIN [edw].[fact_SupplierInvoice] inv 
		ON ref.[SupplierInvoice] = inv.[SupplierInvoiceID] 
)
,
SupplierPurchasingOrg AS
(
	SELECT
		-- [dm_sales].[vw_dim_SupplierPurchasingOrg] as org
			org.[SupplierID] 
		,	org.[PurchasingOrganizationID]
		,	org.[PurchasingOrganization]
		,	CONCAT(org.[PurchasingOrganizationID], ' ', org.[PurchasingOrganization]) AS [PurchasingOrgID_Name]
		,	org.[PurchasingGroupID]
		,	org.[PurchasingGroup]
		,	CONCAT(org.[PurchasingGroupID], ' ', org.[PurchasingGroup]) AS [PurchasingGroupID_Name]
		-- [dm_sales].[vw_dim_Supplier] as sup 
		,	SUBSTRING(sup.SupplierID, PATINDEX('%[^0]%', sup.SupplierID+'.'), LEN(sup.SupplierID)) AS [SupplierID_]
		,	sup.[Supplier] AS [SupplierName]
		,	sup.[CountryID]
		,	sup.[Country]
		--,	CONCAT(sup.[CountryID], ' (', sup.[Country], ')') AS [CountryID_Name]
	FROM [dm_sales].[vw_dim_SupplierPurchasingOrg] org 
	LEFT JOIN [edw].[dim_Supplier] sup
		ON org.[SupplierID]  = sup.[SupplierID] --COLLATE SQL_Latin1_General_CP1_CI_AS 
)
	SELECT 
			itm.[sk_fact_PurchasingDocumentItem]
		,	itm.[PurchasingDocument]
		,	itm.[PurchasingDocumentItem]
		,	itm.[MaterialID]
		,	SUBSTRING(itm.[MaterialID], PATINDEX('%[^0]%', itm.[MaterialID]+'.'), LEN(itm.[MaterialID])) as [MaterialID_]
		,	itm.[DocumentCurrencyID]
		,	'#' AS [DisplayCurrency]
		,	itm.[PlantID]
		,	itm.[CompanyCodeID]
		,	itm.[MaterialGroupID]
		,	itm.[PurchaseContract]
		,	itm.[PurchaseContractItem]
		,	itm.[NetAmount]
		,	itm.[PurchaseOrderQuantity]
		,	itm.[StorageLocationID]
		,	itm.[OrderPriceUnit]
		,	itm.[NetPriceAmount]
		,	itm.[NetPriceQuantity]
		,	itm.[PurchasingDocumentItemCategoryID]
		,	itm.[NextDeliveryOpenQuantity]
		,	itm.[NextDeliveryDate]
		,	itm.[IsCompletelyDelivered]
		,	CASE 
				WHEN itm.[IsCompletelyDelivered] = 'X'
				THEN 'Yes'
				ELSE 'No'
			END AS [IsDelivered]
		, CASE 
				WHEN itm.[IsCompletelyDelivered] != 'X'
				THEN '#'
				ELSE itm.[IsCompletelyDelivered]
			END AS [IsDeliveredFlag]
		,	itm.[OrderQuantityUnit]
		,	itm.[CostCenterID]
		,	'#' AS [CostCenterName]
		,	itm.[GLAccountID]
		,	'#' AS [GLAccountName]
		,	itm.[GoodsReceiptQuantity]
		--,	ISNULL(itm.[CostCenterID], '#') AS [CostCenterID__]
		--,	ISNULL(itm.[GLAccount], '#') AS [GLAccount__]
		--,	ISNULL(itm.[GoodsReceiptQuantity], '#') AS [GoodsReceiptQuantity__]
		,	itm.[t_applicationId]
		,	itm.[t_extractionDtm]
		--,	doc.[PurchasingDocumentCategory] -- Not from EDW and don't need to use in report 
		,	doc.[CreationDate]
		--,	DATEPART( year, doc.[CreationDate]) AS [CalendarYear]
		,	doc.[CreatedByUser]
		,	doc.[PurchasingDocumentOrderDate]
		-- SupplierPurchasingOrg
		,	org.[SupplierID] 
		,	org.[PurchasingOrganizationID]
		,	org.[PurchasingOrganization]
		,	org.[PurchasingOrgID_Name]
		,	org.[PurchasingGroupID]
		,	org.[PurchasingGroup]
		,	org.[PurchasingGroupID_Name]
		,	org.[SupplierID_]
		,	org.[SupplierName]
		,	org.[CountryID]
		,	org.[Country]
		--,	org.[CountryID_Name]
		-- SupplierInvoice
		,	inv.[InvoicingPartyID]
		,	inv.[InvoiceDocumentDate]
		--,	inv.[CreationDate]
		,	inv.[PostingDate]
		,	inv.[InvoiceGrossAmount]
		,	inv.[SupplierInvoiceID] 
		-- Disctionaries 
		,	uom.[UnitOfMeasureLongName]
		,	p.[Product]
		,	pl.[Plant]
		,	mg.[MaterialGroup]
		,	cur.[Currency]
		-- Formatted fields 
		,	CONCAT(CAST (itm.[NetPriceAmount] AS decimal (15,2)), ' ', itm.[DocumentCurrencyID])  AS UOM
		,	CONCAT(itm.[PurchaseOrderQuantity], ' ', itm.[OrderQuantityUnit]) AS POAmount
			
	FROM [dm_sales].[vw_fact_PurchasingDocumentItem] itm
	LEFT JOIN [edw].[fact_PurchasingDocument] doc
		ON itm.[PurchasingDocument] = doc.[PurchasingDocument]
	LEFT JOIN SupplierPurchasingOrg org 
		ON doc.[SupplierID] = org.[SupplierID]
	LEFT JOIN SupplierInvoice inv
		ON itm.[sk_fact_PurchasingDocumentItem] = inv.[sk_fact_PurchasingDocumentItem] 
	-- Dictionaries
	LEFT JOIN [edw].[dim_UnitOfMeasure] uom
		ON itm.[OrderPriceUnit] = uom.[UnitOfMeasureID]
	LEFT JOIN [edw].[dim_Product] p
		ON itm.[MaterialID] /*COLLATE SQL_Latin1_General_CP1_CI_AS*/ = p.[ProductID] 
	LEFT JOIN [edw].[dim_Plant] pl
		ON	itm.[PlantID] = pl.[PlantID] /*COLLATE SQL_Latin1_General_CP1_CI_AS*/
	LEFT JOIN [edw].[dim_MaterialGroup] mg 
		ON itm.[MaterialGroupID] = mg.[MaterialGroupID] /*COLLATE SQL_Latin1_General_CP1_CI_AS*/
	LEFT JOIN [edw].[dim_Currency] cur
		ON itm.[DocumentCurrencyID] = cur.[CurrencyID]


