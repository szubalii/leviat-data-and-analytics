CREATE VIEW [dm_sales].[vw_dim_SalesEmployee]
AS 
SELECT
      Person,
      PersonFullName
FROM  [base_s4h_cax].[I_PersonWorkAgreement_1]




