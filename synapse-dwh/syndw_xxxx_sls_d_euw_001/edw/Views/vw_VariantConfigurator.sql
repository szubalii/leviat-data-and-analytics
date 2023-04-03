CREATE VIEW [edw].[vw_VariantConfigurator]
AS
SELECT
    SalesDocument,
    SalesDocumentItem,
    ProductID,
    ProductExternalID,
    substring(CharacteristicName,5,LEN(CharacteristicName)-4) AS CharacteristicName,
    CASE
      WHEN CharValue<>CharValueDescription THEN CONCAT(CharValue,'_',CharValueDescription)
      WHEN CharValue IS NULL AND CharValueDescription IS NOT NULL THEN CharValueDescription
      WHEN CharValue IS NOT NULL AND CharValueDescription IS NULL THEN CharValue
      WHEN CharValue = CharValueDescription THEN CharValue
      ELSE NULL
    END AS CharacteristicDescription
FROM
    [base_s4h_cax].[Z_C_VariantConfig_active]

