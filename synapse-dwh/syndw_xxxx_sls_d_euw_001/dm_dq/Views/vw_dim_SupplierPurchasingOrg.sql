CREATE VIEW [dm_dq].[vw_dim_SupplierPurchasingOrg]
AS
SELECT
    Supplier
    , PurchasingOrganization
    , CalculationSchemaGroupCode
    , DeletionIndicator
    , PaymentTerms
FROM
    [base_s4h_cax].[I_SupplierPurchasingOrg]