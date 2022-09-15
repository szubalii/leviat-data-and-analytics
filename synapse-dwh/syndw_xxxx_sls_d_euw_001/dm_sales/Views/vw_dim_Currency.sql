CREATE VIEW [dm_sales].[vw_dim_Currency]
AS
SELECT
  [CurrencyID],
  [Currency]
FROM
  [edw].[dim_Currency]
