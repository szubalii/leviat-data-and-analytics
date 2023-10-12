

-- TODO instead of creating 2 CTEs from [edw].[fact_SalesDocumentItem], do this directly
-- in one go, so no JOINS are required. 


SalesDocumentItem_EUR AS (
    SELECT
        SDI_EUR.[SalesDocument]
        ,SDI_EUR.[SalesDocumentItem]
        ,CASE
            WHEN
                SDI_EUR.[OrderQuantity] > 0 
            THEN
                SDI_EUR.[NetAmount] / SDI_EUR.[OrderQuantity]
         END AS [SDI_PricePerPiece_EUR]
        ,SDI_EUR.[CostAmount] AS [SDI_CostAmount_EUR]
        ,SDI_EUR.[NetAmount] AS [SDI_NetAmount_EUR]
    FROM
        [edw].[fact_SalesDocumentItem] AS SDI_EUR
    WHERE
        [CurrencyTypeID] = 30
        AND
        [t_applicationId] LIKE 's4h-ca%'
),
SalesDocumentItem_LC AS (
    SELECT
        SDI_LC.[SalesDocument]
        ,SDI_LC.[SalesDocumentItem]
        ,CASE
            WHEN SDI_LC.[OrderQuantity] > 0
            THEN SDI_LC.[NetAmount] / SDI_LC.[OrderQuantity]
         END AS [SDI_PricePerPiece_LC]
        ,SDI_LC.[CurrencyID] AS [SDI_LocalCurrency]
        ,SDI_LC.[CostAmount] AS [SDI_CostAmount_LC]
        ,SDI_LC.[NetAmount] AS [SDI_NetAmount_LC]
    FROM
        [edw].[fact_SalesDocumentItem] AS SDI_LC
    WHERE
        [CurrencyTypeID] = 10
        AND
        [t_applicationId] LIKE 's4h-ca%'                  
)
,
SalesDocumentItem_LC_EUR AS (
    SELECT
        SDI.[SalesDocument]
        ,SDI.[SalesDocumentItem]
        ,SDI.[CreationDate] AS [SDI_CreationDate]
        ,SDI.[RequestedDeliveryDate] AS [SDI_RequestedDeliveryDate]
        ,SDI_LC.[SDI_PricePerPiece_LC]
        ,SDI_EUR.[SDI_PricePerPiece_EUR]
        ,SDI_LC.[SDI_LocalCurrency]
        ,SDI.[SalesDocumentTypeID] AS [SDI_SalesDocumentTypeID]
        ,SDI.[IsReturnsItemID] AS [SDI_IsReturnsItemID]
        ,SDI.[BillToPartyID] AS [SDI_BillToParty]
        ,SDI.[ConfdDeliveryQtyInBaseUnit] AS [SDI_ConfdDeliveryQtyInBaseUnit]
        ,SDI.[ConfdDelivQtyInOrderQtyUnit] AS [SDI_ConfdDelivQtyInOrderQtyUnit]
        ,SDI_LC.[SDI_CostAmount_LC]
        ,SDI_EUR.[SDI_CostAmount_EUR]
        ,SDI.[DeliveryBlockStatusID] AS [SDI_DeliveryBlockStatusID]
        ,SDI.[ExchangeRateDate] AS [SDI_ExchangeRateDate]
        ,SDI.[ExchangeRateTypeID] AS [SDI_ExchangeRateType]
        ,SDI_LC.[SDI_NetAmount_LC]
        ,SDI_EUR.[SDI_NetAmount_EUR]
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
    LEFT JOIN
        SalesDocumentItem_EUR SDI_EUR
        ON
            SDI.[SalesDocument] = SDI_EUR.[SalesDocument]
            AND
            SDI.[SalesDocumentItem] = SDI_EUR.[SalesDocumentItem]
    LEFT JOIN
        SalesDocumentItem_LC SDI_LC
        ON
            SDI.[SalesDocument] = SDI_LC.[SalesDocument]
            AND
            SDI.[SalesDocumentItem] = SDI_LC.[SalesDocumentItem]
     WHERE
        [CurrencyTypeID] in (10,30)
        AND
        [t_applicationId] LIKE 's4h-ca%'
    GROUP BY
       SDI.[SalesDocument]
        ,SDI.[SalesDocumentItem]
        ,SDI.[CreationDate]
        ,SDI.[RequestedDeliveryDate]
        ,SDI_LC.[SDI_PricePerPiece_LC]
        ,SDI_EUR.[SDI_PricePerPiece_EUR]
        ,SDI_LC.[SDI_LocalCurrency]
        ,SDI.[SalesDocumentTypeID]
        ,SDI.[IsReturnsItemID]
        ,SDI.[BillToPartyID]
        ,SDI.[ConfdDeliveryQtyInBaseUnit]
        ,SDI.[ConfdDelivQtyInOrderQtyUnit]
        ,SDI_LC.[SDI_CostAmount_LC]
        ,SDI_EUR.[SDI_CostAmount_EUR]
        ,SDI.[DeliveryBlockStatusID]
        ,SDI.[ExchangeRateDate]
        ,SDI.[ExchangeRateTypeID]
        ,SDI_LC.[SDI_NetAmount_LC]
        ,SDI_EUR.[SDI_NetAmount_EUR]
        ,SDI.[NetPriceQuantityUnitID]
        ,SDI.[OrderID]
        ,SDI.[OrderQuantity]
        ,SDI.[OrderQuantityUnitID]
        ,SDI.[OverallTotalDeliveryStatusID]
        ,SDI.[PayerPartyID]
        ,SDI.[RouteID]
        ,SDI.[SalesDocumentItemCategoryID]
        ,SDI.[SalesOrganizationCurrencyID]
        ,SDI.[SDDocumentCategoryID]
        ,SDI.[SDDocumentRejectionStatusID]
        ,SDI.[StorageLocationID]
        ,SDI.[SalesDocumentDate]
)