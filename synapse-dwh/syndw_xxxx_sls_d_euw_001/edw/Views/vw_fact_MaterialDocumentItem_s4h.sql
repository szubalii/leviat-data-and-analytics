CREATE VIEW [edw].[vw_fact_MaterialDocumentItem_s4h]
AS
SELECT
  *
FROM
  [edw].[fact_MaterialDocumentItem]
WHERE
  t_applicationId LIKE '%s4h%'
