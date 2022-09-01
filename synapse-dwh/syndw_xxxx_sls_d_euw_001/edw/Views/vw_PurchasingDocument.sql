CREATE VIEW [edw].[vw_PurchasingDocument]
	AS 
SELECT
   PD.[PurchasingDocument]                AS [PurchasingDocumentID],
   PD.[Supplier]                          AS [SupplierID],
   PD.[PurchasingDocumentCategory]        AS [PurchasingDocumentCategoryID],
   PD.[PurchasingDocumentType],
   PD.[CreationDate],
   PD.[CreatedByUser],
   PD.[CompanyCode],
   PD.[PurchasingDocumentOrderDate],
   PD.[PurchasingOrganization],
   PD.[PurchasingGroup]                   AS [PurchasingGroupID],
   PD.[SupplyingPlant]                    AS [PlantID],
   PD.[PurchasingProcessingStatus],
   PD.[PurchaseContract],
   PD.[t_applicationId],
   PD.[t_extractionDtm]
FROM 
   [base_s4h_cax].[I_PurchasingDocument] PD

