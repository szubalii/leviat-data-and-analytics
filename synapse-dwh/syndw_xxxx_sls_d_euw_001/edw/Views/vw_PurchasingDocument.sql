CREATE VIEW [edw].[vw_PurchasingDocument]
	AS 
SELECT
   PD.[PurchasingDocument],
   PD.[Supplier]                          AS [SupplierID],
   PD.[PurchasingDocumentCategory]        AS [PurchasingDocumentCategoryID],
   PD.[PurchasingDocumentType]            AS [PurchasingDocumentTypeID],
   PD.[CreationDate],
   PD.[CreatedByUser],
   PD.[CompanyCode]                       AS [CompanyCodeID],
   PD.[PurchasingDocumentOrderDate],
   PD.[PurchasingOrganization]            AS [PurchasingOrganizationID],
   PD.[PurchasingGroup]                   AS [PurchasingGroupID],
   PD.[SupplyingPlant]                    AS [SupplyingPlantID],
   PD.[PurchasingProcessingStatus]        AS [PurchasingProcessingStatusID],
   PD.[PurchaseContract],
   PD.[t_applicationId],
   PD.[t_extractionDtm]
FROM 
   [base_s4h_cax].[I_PurchasingDocument] PD

