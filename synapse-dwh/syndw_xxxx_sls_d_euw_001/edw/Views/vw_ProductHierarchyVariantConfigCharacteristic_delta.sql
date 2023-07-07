CREATE VIEW [edw].[vw_ProductHierarchyVariantConfigCharacteristic_delta]
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
    LEFT JOIN
        [base_ff].[ConfigurableProductCharacteristic] AS mcpc
        ON
            VC.[CharacteristicName] = mcpc.[CharacteristicName]
    WHERE
        mcpc.[CharacteristicCategory] = 'ProductHierarchy'
    GROUP BY
          VC.[SalesDocument]
        , VC.[SalesDocumentItem]
)

SELECT
      CN.[SalesDocument]
    , CN.[SalesDocumentItem]
    , VC.[ProductID]
    , VC.[ProductExternalID]
    , CONCAT_WS('_', VC.[ProductID], COALESCE(map.[ProductHierarchyNew],VC.[CharValue])) AS [ProductSurrogateKey]
    , VC.[Configuration]
    , VC.[Instance]
    , VC.[LastChangeDate]
    , CN.[CharacteristicName]
    , VC.[CharacteristicDescription]
    , VC.[DecimalValueFrom]
    , COALESCE(map.[ProductHierarchyNew],VC.[CharValue])                                AS [CharValue]
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
        VC.[ProductID] = map.[MaterialID]
        AND
        VC.[CharValue] = map.[ProductHierarchy]
