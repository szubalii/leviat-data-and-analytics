CREATE VIEW [dm_sales].[vw_dim_PurchasingDocument]
  AS 
   SELECT
      PD.[PurchasingDocumentID],
      PD.[SupplierID],
      PD.[PurchasingDocumentCategoryID], 
      PDCT.[PurchasingDocumentCategoryName],    
      PD.[PurchasingDocumentTypeID],
      dim_PDT.[PurchasingDocumentTypeName],   
      PD.[CreationDate],   
      PD.[CreatedByUser],  
      PD.[PurchasingDocumentOrderDate],
      PD.[PurchasingOrganizationID],
      PO.[PurchasingOrganizationName],
      PD.[PurchasingGroupID],
      PG.[PurchasingGroupName], 
      PD.[PlantID],
      PD.[CompanyCode], 
      PD.[PurchasingProcessingStatusID],
      PDST.[PurchasingDocumentStatusName], 
      PD.[t_applicationId],
      PD.[t_extractionDtm]
   FROM  
      [edw].[dim_PurchasingDocument] PD
   LEFT JOIN   
      [edw].[dim_PurchasingDocumentType] dim_PDT
      ON 
            dim_PDT.[PurchasingDocumentTypeID] = PD.[PurchasingDocumentTypeID]
         AND
            dim_PDT.[PurchasingDocumentCategoryID] = PD.[PurchasingDocumentCategoryID]
   LEFT JOIN      
      [base_s4h_cax].[I_PurchasingOrganization] PO
      ON
         PO.[PurchasingOrganization] = PD.[PurchasingOrganizationID]
   LEFT JOIN 
      [base_s4h_cax].[I_PurchasingGroup] PG
      ON
         PG.[PurchasingGroup] = PD.[PurchasingGroupID] 
   LEFT JOIN 
      [base_s4h_cax].[I_PurchasingDocumentStatusText] PDST
      ON 
            PDST.[PurchasingDocumentStatus] = PD.[PurchasingProcessingStatusID]
         AND 
            PDST.[Language] = 'E'
   LEFT JOIN 
      [base_s4h_cax].[I_PurgDocumentCategoryText] PDCT
      ON 
            PDCT.[PurchasingDocumentCategory]  = PD.[PurchasingDocumentCategoryID]
         AND
         PDCT.[Language] = 'E'