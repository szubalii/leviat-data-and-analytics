CREATE VIEW [edw].[vw_BillingDocProject]
AS
SELECT
  [SDDocument]
, [Customer] AS ProjectID
, [FullName] AS Project
, [Customer] + '_' + [FullName] AS ProjectID_Name
, [t_applicationId]
, [t_extractionDtm]
FROM
  [edw].[vw_BillingDocumentPartnerFs]
WHERE
  [PartnerFunction] = 'ZP'
