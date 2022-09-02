CREATE VIEW [dm_sales].[vw_dim_SupplierCompany]
  AS 
    SELECT 
      [SupplierID],                     
      [CompanyCodeID],                  
      [PaymentMethodsList],             
      [t_applicationId],                
      [t_extractionDtm]                
    FROM 
      [edw].[dim_SupplierCompany]