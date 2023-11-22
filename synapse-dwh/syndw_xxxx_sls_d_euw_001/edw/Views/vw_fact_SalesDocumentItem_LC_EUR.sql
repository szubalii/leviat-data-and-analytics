CREATE VIEW [edw].[vw_fact_SalesDocumentItem_LC_EUR] AS
WITH PVT_CTE AS(
SELECT * FROM (
SELECT
     SDI.[SalesDocument]
    ,SDI.[SalesDocumentItem]
    ,SDI.[CreationDate] AS [SDI_CreationDate]
    ,SDI.[RequestedDeliveryDate] AS [SDI_RequestedDeliveryDate]
    ,CASE
        WHEN SDI.[OrderQuantity] > 0
        THEN SDI.[NetAmount] / SDI.[OrderQuantity]
     END AS [SDI_PricePerPiece]
    ,SDI.[CurrencyID]
    ,SDI.[TransactionCurrencyID] AS [SDI_LocalCurrency]
    ,SDI.[SalesDocumentTypeID] AS [SDI_SalesDocumentTypeID]
    ,SDI.[IsReturnsItemID] AS [SDI_IsReturnsItemID]
    ,SDI.[BillToPartyID] AS [SDI_BillToParty]
    ,SDI.[ConfdDeliveryQtyInBaseUnit] AS [SDI_ConfdDeliveryQtyInBaseUnit]
    ,SDI.[ConfdDelivQtyInOrderQtyUnit] AS [SDI_ConfdDelivQtyInOrderQtyUnit]
    ,SDI.[CostAmount]
    ,SDI.[DeliveryBlockStatusID] AS [SDI_DeliveryBlockStatusID]
    ,SDI.[ExchangeRateDate] AS [SDI_ExchangeRateDate]
    ,SDI.[ExchangeRateTypeID] AS [SDI_ExchangeRateType]
    ,SDI.[NetAmount]
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
    ,SDI.[CurrencyTypeID] AS [CurrencyTypeIDForCostAmount]
    ,SDI.[CurrencyTypeID] + '1' AS [CurrencyTypeIDForNetAmount]
    ,SDI.[CurrencyTypeID] + '2' AS [CurrencyTypeIDForPricePerPiece]
FROM
    [edw].[fact_SalesDocumentItem] AS SDI
 WHERE
    [CurrencyTypeID] IN (10,30)
    AND
    [t_applicationId] LIKE 's4h-ca%'
) P
PIVOT
(SUM([CostAmount]) for [CurrencyTypeIDForCostAmount] IN ([10],[30])) AS PVT_CostAmount
PIVOT
(SUM([NetAmount]) for [CurrencyTypeIDForNetAmount] IN ([101],[301])) AS PVT_NetAmount
PIVOT
(SUM([SDI_PricePerPiece]) for [CurrencyTypeIDForPricePerPiece] IN ([102],[302])) AS PVT_PricePerPiece
)
SELECT 
     [SalesDocument]
    ,[SalesDocumentItem]
    ,[SDI_CreationDate]
    ,[SDI_RequestedDeliveryDate]
    ,MAX([102]) AS [SDI_PricePerPiece_LC]
    ,MAX([302]) AS [SDI_PricePerPiece_EUR]
    ,[SDI_LocalCurrency]
    ,[SDI_SalesDocumentTypeID]
    ,[SDI_IsReturnsItemID]
    ,[SDI_BillToParty]
    ,[SDI_ConfdDeliveryQtyInBaseUnit]
    ,[SDI_ConfdDelivQtyInOrderQtyUnit]
    ,MAX([10]) AS [SDI_CostAmount_LC]
    ,MAX([30]) AS [SDI_CostAmount_EUR] 
    ,[SDI_DeliveryBlockStatusID]
    ,[SDI_ExchangeRateDate]
    ,[SDI_ExchangeRateType]   
    ,MAX([101]) AS [SDI_NetAmount_LC]
    ,MAX([301]) AS [SDI_NetAmount_EUR]
    ,[SDI_NetPriceQuantityUnit]
    ,[SDI_OrderID]
    ,[SDI_OrderQuantity]
    ,[SDI_OrderQuantityUnit]
    ,[SDI_OverallTotalDeliveryStatusID]
    ,[SDI_PayerParty]
    ,[SDI_Route]
    ,[SDI_SalesDocumentItemCategory]
    ,[SDI_SalesOrganizationCurrency]
    ,[SDI_SDDocumentCategory]
    ,[SDI_SDDocumentRejectionStatusID]
    ,[SDI_StorageLocationID]
    ,[SDI_SalesDocumentDate]
FROM
    PVT_CTE
GROUP BY
     [SalesDocument]
    ,[SalesDocumentItem]
    ,[SDI_CreationDate]
    ,[SDI_RequestedDeliveryDate]
    ,[SDI_LocalCurrency]
    ,[SDI_SalesDocumentTypeID]
    ,[SDI_IsReturnsItemID]
    ,[SDI_BillToParty]
    ,[SDI_ConfdDeliveryQtyInBaseUnit]
    ,[SDI_ConfdDelivQtyInOrderQtyUnit]
    ,[SDI_DeliveryBlockStatusID]
    ,[SDI_ExchangeRateDate]
    ,[SDI_ExchangeRateType]
    ,[SDI_NetPriceQuantityUnit]
    ,[SDI_OrderID]
    ,[SDI_OrderQuantity]
    ,[SDI_OrderQuantityUnit]
    ,[SDI_OverallTotalDeliveryStatusID]
    ,[SDI_PayerParty]
    ,[SDI_Route]
    ,[SDI_SalesDocumentItemCategory]
    ,[SDI_SalesOrganizationCurrency]
    ,[SDI_SDDocumentCategory]
    ,[SDI_SDDocumentRejectionStatusID]
    ,[SDI_StorageLocationID]
    ,[SDI_SalesDocumentDate]