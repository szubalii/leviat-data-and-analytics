CREATE VIEW [edw].[vw_ProductHierarchyVariantConfigCharacteristic]
AS
-- There exist two characteristics that fall within CharacteristicCategory 'ProductHierarchy':
-- ZCH_SO_ITEM_PROD_HIERARCHY1 (old)
-- ZCH_SO_ITEM_PROD_HIERARCHY  (new)

-- In case a SalesDocument-SalesDocumentItem is linked to both, only select the value of 
-- ZCH_SO_ITEM_PROD_HIERARCHY
WITH CN AS (
    SELECT
          VC.[SalesDocument]
        , VC.[SalesDocumentItem]
        , MIN(VC.[CharacteristicName]) AS [CharacteristicName] -- take ZCH_SO_ITEM_PROD_HIERARCHY
    FROM [base_s4h_cax].[Z_C_VariantConfig_ProductHierarchy_F] VC
    GROUP BY
          VC.[SalesDocument]
        , VC.[SalesDocumentItem]
)

SELECT
      CN.[SalesDocument]
    , CN.[SalesDocumentItem]
    , VC.[ProductID]
    , VC.[ProductExternalID]
    , CONCAT_WS('_', VC.[ProductID], COALESCE(map.[new_ProductHierarchyNode],VC.[CharValue])) AS [ProductSurrogateKey]
    , VC.[Configuration]
    , VC.[Instance]
    , VC.[LastChangeDate]
    , CN.[CharacteristicName]
    , VC.[CharacteristicDescription]
    , VC.[DecimalValueFrom]
    , COALESCE(maphn.[NewProductHierarchyNode],map.[new_ProductHierarchyNode],VC.[CharValue]) AS [CharValue]
    , VC.[CharValueDescription]
    , VC.[t_applicationId]
    , VC.[t_extractionDtm]
FROM CN
LEFT JOIN
    [base_s4h_cax].[Z_C_VariantConfig_ProductHierarchy_F] VC
    ON
        VC.[SalesDocument] = CN.[SalesDocument]
        AND
        VC.[SalesDocumentItem] = CN.[SalesDocumentItem]
        AND
        VC.[CharacteristicName] = CN.[CharacteristicName]
LEFT JOIN
    [base_ff].[ProductHierarchyNode] map
    ON
        VC.[ProductID] = map.[ProductID]
        AND
        VC.[CharValue] = map.[old_ProductHierarchyNode]
LEFT JOIN
    [base_ff].[ProductHierarchyNodeMapping] maphn
    ON
        maphn.[OldProductHierarchyNode] = COALESCE(map.[new_ProductHierarchyNode],VC.[CharValue])