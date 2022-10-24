CREATE VIEW [dm_sales].[vw_fact_OrderOpenAmount] AS 

SELECT
		  doc.SalesDocument 
		, doc.SalesDocumentItem
		, doc.CurrencyTypeID
		, doc.CurrencyType
		, doc.CurrencyID
		, doc.SDDocumentCategoryID
		, dimSDDC.SDDocumentCategory
		, doc.SalesDocumentTypeID
		, dimSDT.SalesDocumentType
		, doc.SalesOrganizationID
		, doc.NetAmount
		, doc.OpenDeliveryNetAmount
		, doc.MaterialID
		, doc.BillingDocumentDate
		, doc.CreationDate
		, doc.ItemBillingIncompletionStatusID
		, dimIBIS.ItemBillingIncompletionStatus
		, doc.SDDocumentRejectionStatusID
		, dimSDDRjS.SDDocumentRejectionStatus
		, doc.OverallSDProcessStatusID
		, dimOSS.OverallSDProcessStatus
		, doc.OverallTotalDeliveryStatusID
		, dimOTDS.OverallTotalDeliveryStatus
		, doc.TotalSDDocReferenceStatusID
		, dimTSDDRS.TotalSDDocReferenceStatus
		, doc.InOutID
		, doc.t_applicationId
		, doc.t_extractionDtm

FROM [edw].[fact_SalesDocumentItem] doc


left join [edw].[dim_SDDocumentCategory] dimSDDC
 ON dimSDDC.[SDDocumentCategoryID] = doc.[SDDocumentCategoryID]

left join [edw].[dim_SalesDocumentType] dimSDT
 ON dimSDT.[SalesDocumentTypeID] = doc.[SalesDocumentTypeID]

left join [edw].[dim_OverallSDProcessStatus] dimOSS
 ON dimOSS.[OverallSDProcessStatusID] = doc.[OverallSDProcessStatusID]

left join [edw].[dim_OverallTotalDeliveryStatus] dimOTDS
 ON dimOTDS.[OverallTotalDeliveryStatusID] = doc.[OverallTotalDeliveryStatusID]

left join [edw].[dim_TotalSDDocReferenceStatus] dimTSDDRS
 ON dimTSDDRS.[TotalSDDocReferenceStatusID] = doc.[TotalSDDocReferenceStatusID]

left join [edw].[dim_ItemBillingIncompletionStatus] dimIBIS
 ON dimIBIS.[ItemBillingIncompletionStatusID] = doc.[ItemBillingIncompletionStatusID]

left join [edw].[dim_SDDocumentRejectionStatus] dimSDDRjS
 ON dimSDDRjS.[SDDocumentRejectionStatusID] = doc.[SDDocumentRejectionStatusID]

WHERE doc.t_applicationId LIKE '%s4h%'