CREATE VIEW [dm_dq].[vw_dim_Supplier]
AS
SELECT
    Supplier
    , SupplierAccountGroup
    , DeletionIndicator
    , Country
FROM
    [base_s4h_cax].[I_Supplier]