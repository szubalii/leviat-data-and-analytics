CREATE VIEW [dm_sales].[vw_dim_SalesEmployee]
AS 
SELECT
  PersonWorkAgreement AS SalesEmployeeID,
  PersonFullName AS SalesEmployee
FROM
  [base_s4h_cax].[I_PersonWorkAgreement_1]
