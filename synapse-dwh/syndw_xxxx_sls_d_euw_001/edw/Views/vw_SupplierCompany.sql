CREATE VIEW [edw].[vw_SupplierCompany]
  AS 
  SELECT 
    [Supplier]            AS [SupplierID],                       
    [CompanyCode]         AS [CompanyCodeID],                    
    [PaymentMethodsList],                         
    [t_applicationId], 
    [t_extractionDtm]             
  FROM 
    [base_s4h_cax].[I_SupplierCompany]