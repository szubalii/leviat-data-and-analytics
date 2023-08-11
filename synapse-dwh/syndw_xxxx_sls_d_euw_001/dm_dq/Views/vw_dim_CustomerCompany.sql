CREATE VIEW [dm_dq].[vw_dim_CustomerCompany]
AS
SELECT 
    Customer
    , CompanyCode
    , DeletionIndicator
    , PaymentTerms
    , PaymentMethodsList
FROM
    [base_s4h_cax].[I_CustomerCompany]