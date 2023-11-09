CREATE VIEW [edw].[vw_fact_SalesDocumentItem_LC_EUR] AS
WITH SalesDocumentItem_LC_EUR AS (
    SELECT
        SDI.[SalesDocument]
        ,SDI.[SalesDocumentItem]
        ,SDI.[CreationDate] AS [SDI_CreationDate]
        ,SDI.[RequestedDeliveryDate] AS [SDI_RequestedDeliveryDate]
        ,CASE
            WHEN SDI.[OrderQuantity] > 0 AND  [CurrencyTypeID] = 10
            THEN SDI.[NetAmount] / SDI.[OrderQuantity]
         END AS [SDI_PricePerPiece_LC]
        ,CASE
            WHEN
                SDI.[OrderQuantity] > 0 AND  [CurrencyTypeID] = 30
            THEN
                SDI.[NetAmount] / SDI.[OrderQuantity]
         END AS [SDI_PricePerPiece_EUR]
        ,CASE
            WHEN [CurrencyTypeID] = 10
            THEN SDI.[CurrencyID] 
         END AS [SDI_LocalCurrency]
        ,SDI.[SalesDocumentTypeID] AS [SDI_SalesDocumentTypeID]
        ,SDI.[IsReturnsItemID] AS [SDI_IsReturnsItemID]
        ,SDI.[BillToPartyID] AS [SDI_BillToParty]
        ,SDI.[ConfdDeliveryQtyInBaseUnit] AS [SDI_ConfdDeliveryQtyInBaseUnit]
        ,SDI.[ConfdDelivQtyInOrderQtyUnit] AS [SDI_ConfdDelivQtyInOrderQtyUnit]
        ,CASE
            WHEN [CurrencyTypeID] = 10
            THEN SDI.[CostAmount] 
         END AS [SDI_CostAmount_LC]
        ,CASE
            WHEN [CurrencyTypeID] = 30
            THEN SDI.[CostAmount] 
         END AS [SDI_CostAmount_EUR]
        ,SDI.[DeliveryBlockStatusID] AS [SDI_DeliveryBlockStatusID]
        ,SDI.[ExchangeRateDate] AS [SDI_ExchangeRateDate]
        ,SDI.[ExchangeRateTypeID] AS [SDI_ExchangeRateType]
        ,CASE
            WHEN [CurrencyTypeID] = 10
            THEN SDI.[NetAmount] 
         END AS [SDI_NetAmount_LC]
        ,CASE
            WHEN [CurrencyTypeID] = 30
            THEN SDI.[NetAmount] 
         END AS [SDI_NetAmount_EUR]
        ,SDI.[NetPriceQuantityUnitID] AS [SDI_NetPriceQuantityUnit]
        ,SDI.[OrderID] AS [SDI_OrderID]
        ,SDI.[OrderQuantity] AS [SDI_OrderQuantity]
        ,SDI.[OrderQuantityUnitID] AS [SDI_OrderQuantityUnit]
        ,SDI.[OverallTotalDeliveryStatusID] AS [SDI_OverallTotalDeliveryStatusID]
        ,SDI.[PayerPartyID] AS [SDI_PayerParty]
        ,SDI.[RouteID] AS [SDI_Route]
        ,SDI.[SalesDocumentItemCategoryID] AS [SDI_SalesDocumentItemCategory]
        ,SDI.[SalesOrganizationCurrencyID] AS [SDI_SalesOrganizationCurrency]
        ,SDI.[SDDocumentCategoryID] AS [SDI_SDDocumentCategory]
        ,SDI.[SDDocumentRejectionStatusID] AS [SDI_SDDocumentRejectionStatusID]
        ,SDI.[StorageLocationID] AS [SDI_StorageLocationID]
        ,SDI.[SalesDocumentDate] AS [SDI_SalesDocumentDate]
    FROM
        [edw].[fact_SalesDocumentItem] AS SDI
     WHERE
        [CurrencyTypeID] in (10,30)
        AND
        [t_applicationId] LIKE 's4h-ca%'
)
SELECT
    SDI.[SalesDocument]
    ,SDI.[SalesDocumentItem]
    ,SDI.[SDI_CreationDate]
    ,SDI.[SDI_RequestedDeliveryDate]
    ,MAX(SDI.[SDI_PricePerPiece_LC]) AS [SDI_PricePerPiece_LC]
    ,MAX(SDI.[SDI_PricePerPiece_EUR]) AS [SDI_PricePerPiece_EUR]
    ,MAX(SDI.[SDI_LocalCurrency]) AS [SDI_LocalCurrency]
    ,SDI.[SDI_SalesDocumentTypeID]
    ,SDI.[SDI_IsReturnsItemID]
    ,SDI.[SDI_BillToParty]
    ,SDI.[SDI_ConfdDeliveryQtyInBaseUnit]
    ,SDI.[SDI_ConfdDelivQtyInOrderQtyUnit]
    ,MAX(SDI.[SDI_CostAmount_LC]) AS [SDI_CostAmount_LC]
    ,MAX(SDI.[SDI_CostAmount_EUR]) AS [SDI_CostAmount_EUR]
    ,SDI.[SDI_DeliveryBlockStatusID]
    ,SDI.[SDI_ExchangeRateDate]
    ,SDI.[SDI_ExchangeRateType]
    ,MAX(SDI.[SDI_NetAmount_LC]) AS [SDI_NetAmount_LC]
    ,MAX(SDI.[SDI_NetAmount_EUR]) AS [SDI_NetAmount_EUR]
    ,SDI.[SDI_NetPriceQuantityUnit]
    ,SDI.[SDI_OrderID]
    ,SDI.[SDI_OrderQuantity]
    ,SDI.[SDI_OrderQuantityUnit]
    ,SDI.[SDI_OverallTotalDeliveryStatusID]
    ,SDI.[SDI_PayerParty]
    ,SDI.[SDI_Route]
    ,SDI.[SDI_SalesDocumentItemCategory]
    ,SDI.[SDI_SalesOrganizationCurrency]
    ,SDI.[SDI_SDDocumentCategory]
    ,SDI.[SDI_SDDocumentRejectionStatusID]
    ,SDI.[SDI_StorageLocationID]
    ,SDI.[SDI_SalesDocumentDate]
FROM
    SalesDocumentItem_LC_EUR SDI
GROUP BY
    SDI.[SalesDocument]
    ,SDI.[SalesDocumentItem]
    ,SDI.[SDI_CreationDate]
    ,SDI.[SDI_RequestedDeliveryDate]
    ,SDI.[SDI_SalesDocumentTypeID]
    ,SDI.[SDI_IsReturnsItemID]
    ,SDI.[SDI_BillToParty]
    ,SDI.[SDI_ConfdDeliveryQtyInBaseUnit]
    ,SDI.[SDI_ConfdDelivQtyInOrderQtyUnit]
    ,SDI.[SDI_DeliveryBlockStatusID]
    ,SDI.[SDI_ExchangeRateDate]
    ,SDI.[SDI_ExchangeRateType]
    ,SDI.[SDI_NetPriceQuantityUnit]
    ,SDI.[SDI_OrderID]
    ,SDI.[SDI_OrderQuantity]
    ,SDI.[SDI_OrderQuantityUnit]
    ,SDI.[SDI_OverallTotalDeliveryStatusID]
    ,SDI.[SDI_PayerParty]
    ,SDI.[SDI_Route]
    ,SDI.[SDI_SalesDocumentItemCategory]
    ,SDI.[SDI_SalesOrganizationCurrency]
    ,SDI.[SDI_SDDocumentCategory]
    ,SDI.[SDI_SDDocumentRejectionStatusID]
    ,SDI.[SDI_StorageLocationID]
    ,SDI.[SDI_SalesDocumentDate]
