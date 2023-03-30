CREATE VIEW [edw].[vw_ProductHierarchyVariantConfigCharacteristicKey]
AS
SELECT
  SalesDocument
, SalesDocumentItem
, CharacteristicName
, CharValue
, ProductSurrogateKey
FROM
    [edw].[vw_ProductHierarchyVariantConfigCharacteristic_delta]
GROUP BY
    SalesDocument,
    SalesDocumentItem,
    CharacteristicName,
    CharValue,
    ProductSurrogateKey