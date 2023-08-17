CREATE VIEW [dm_dq].[vw_dim_Customer]
AS
SELECT
    Customer
    , CustomerAccountGroup
    , DeletionIndicator
    , Country
FROM
    [base_s4h_cax].[I_Customer]