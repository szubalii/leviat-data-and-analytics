CREATE VIEW [edw].[vw_ProductHierarchyVariantConfigCharacteristic_delta]
	AS SELECT
        vc.[SalesDocument]
        , vc.[SalesDocumentItem]
        , vc.[ProductID]
        , vc.[ProductExternalID]
        , CONCAT_WS('_',vc.[ProductID],vc.[CharValue]) AS [ProductSurrogateKey]
        , vc.[Configuration]
        , vc.[Instance]
        , vc.[LastChangeDate]
        , vc.[CharacteristicName]
        , vc.[CharacteristicDescription]
        , vc.[DecimalValueFrom]
        , vc.[CharValue]
        , vc.[CharValueDescription]
        , vc.[t_applicationId]
        , vc.[t_extractionDtm]
    FROM [base_s4h_cax].[Z_C_VariantConfig_active] vc
    LEFT JOIN
        [base_ff].[ConfigurableProductCharacteristic] AS mcpc
        ON
            vc.[CharacteristicName] = mcpc.[CharacteristicName]
    WHERE
        mcpc.[CharacteristicCategory] = 'ProductHierarchy'

