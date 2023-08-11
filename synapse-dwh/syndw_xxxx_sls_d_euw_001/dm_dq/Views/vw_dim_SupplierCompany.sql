CREATE VIEW [dm_dq].[vw_dim_SupplierCompany]
AS
SELECT
    Supplier
    , PaymentTerms
    , CashPlanningGroup
    , DeletionIndicator
    , PaymentMethodsList
FROM
    [base_s4h_cax].[I_SupplierCompany]