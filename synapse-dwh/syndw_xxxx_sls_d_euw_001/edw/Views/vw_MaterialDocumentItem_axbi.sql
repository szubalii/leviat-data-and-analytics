CREATE VIEW [edw].[vw_MaterialDocumentItem_axbi]
	AS 
WITH INVTRANS AS
(
SELECT
        YEAR(FINV.[DATEPHYSICAL])     AS [MaterialDocumentYear]
    ,   FINV.[INVENTDIMID]            AS [MaterialDocument]
    ,   FINV.[RECID]                  AS [MaterialDocumentItem]
    ,   FINV.[ITEMID]                 AS [MaterialID]
    ,   dmINV.[INVENTSITEID]          AS [PlantID]
    ,   dmINV.[INVENTLOCATIONID]
    ,   FINV.[DATAAREAID]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '0'
            THEN SL.[SALESID]
            ELSE NULL
        END                           AS [SalesOrder]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '0'
            THEN SL.[INVENTTRANSID]
            ELSE NULL
        END                           AS [SalesOrderItem]
    ,   FINV.[TRANSTYPE]              AS [GoodsMovementTypeID]
    ,   dmATRNS.[ENUMLABELEN]         AS [GoodsMovementTypeName]
    ,   FINV.[TRANSTYPENAME]
    ,   dmINVTBL.[StockUnit]
    ,   FINV.[DATEPHYSICAL]           AS [HDR_PostingDate]
    ,   FINV.[DATEPHYSICAL]           AS [DocumentDate]
    ,   AX_Cmpny.[CURRENCYCODE]       AS [CompanyCodeCurrency]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '3'
            THEN FPURL.[PURCHID]
            ELSE NULL
        END                           AS [PurchaseOrder]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '3'
            THEN FPURL.[INVENTTRANSID]
            ELSE NULL
        END                           AS [PurchaseOrderItem]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '2'
            THEN FPJRNL.[PRODID]
            ELSE NULL
        END                           AS [Order]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '2'
            THEN FPJRNL.[INVENTTRANSID]
            ELSE NULL
        END                           AS [OrderItem]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '0'
            THEN FCPLT.[PACKINGSLIPID]
            ELSE NULL
        END                           AS [DeliveryDocument]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '0'
            THEN FCPLT.[RECID]
            ELSE NULL
        END                           AS [DeliveryDocumentItem]
    ,   CASE 
            WHEN FINV.[TRANSTYPE] = '0'
            THEN
                CASE
                    WHEN SL.[SALESTYPE] IN ('3','101') THEN 'C'
                    WHEN SL.[SALESTYPE] = '4' THEN 'H'
                    WHEN SL.[SALESTYPE] = '110'
                    THEN
                        CASE
                            WHEN SL.[LineAmount_MST_TransDate] > 0 THEN 'L' 
                            WHEN SL.[LineAmount_MST_TransDate] < 0 THEN 'K' 
                            WHEN SL.[LineAmount_MST_TransDate] = 0
                            THEN    
                                CASE 
                                    WHEN SL.[SALESQTY] > 0 THEN 'L'
                                    WHEN SL.[SALESQTY] < 0 THEN 'K'
                                END
                        END
                END
        END                           AS [SalesDocumentItemCategoryID]
    ,   FINV.[QTY]                    AS [MatlStkChangeQtyInBaseUnit]
    ,   FINV.[QTY]                    AS [MatlCnsmpnQtyInMatlBaseUnit]
    ,   FINV.[CostAmount_Total]
    ,   FINV.[INVENTTRANSID]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '2'
            THEN FPJRNL.[PRODID]
            ELSE NULL
        END                           AS [ManufacturingOrder]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '2'
            THEN FPJRNL.[INVENTTRANSID]
            ELSE NULL
        END                           AS [ManufacturingOrderItem]
    ,   'A'                           AS [PriceControlIndicatorID]
    ,   'Average Price'               AS [PriceControlIndicator]
    ,   FINV.[t_applicationId]
    ,   FINV.[t_extractionDtm]
FROM
    [base_tx_halfen_2_dwh].[FACT_INVENTTRANS] FINV
LEFT JOIN
    [edw].[dim_SAPItemNumberBasicMappingTable] SINMT 
    ON
        FINV.[ITEMID] = SINMT.AXItemnumber
        AND
        UPPER(SINMT.[AXDataAreaId]) = UPPER(DATAAREAID)
        AND
        SINMT.[SAPProductID] IS NOT NULL
LEFT JOIN
    [base_tx_halfen_2_dwh].[DIM_INVENTDIM] dmINV
    ON
        dmINV.INVENTDIMID = FINV.INVENTDIMID
LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_SALESLINE] SL
    ON
        FINV.[INVENTTRANSID] = SL.[INVENTTRANSID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[DIM_ADUENUMTRANSLATIONS] dmATRNS
    ON
        dmATRNS.[ENUMVALUE] = FINV.[TRANSTYPE]
LEFT JOIN
    [base_tx_halfen_2_dwh].[DIM_INVENTTABLE] dmINVTBL
    ON
        FINV.[ITEMID] = dmINVTBL.[ITEMID]
LEFT JOIN
    [base_dw_halfen_1_stg].[AX_Halfen_dbo_COMPANYINFO] AX_Cmpny
    ON
        FINV.[DATAAREAID] = AX_Cmpny.[DATAAREAID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_PURCHLINE] FPURL
    ON
        FINV.[INVENTTRANSID] = FPURL.[INVENTTRANSID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_PRODJOURNALPROD] FPJRNL
    ON
        FINV.[INVENTTRANSID] = FPJRNL.[INVENTTRANSID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_CUSTPACKINGSLIPTRANS] FCPLT
    ON
        FINV.[INVENTTRANSID] = FCPLT.[INVENTTRANSID]
WHERE
    FINV.[STATUSRECEIPT] in ('1','2')
    AND
    FINV.[STATUSISSUE] in ('1','2')
    AND
    FINV.[DATEPHYSICAL]<>''
    AND 
    dmATRNS.ENUMID = '107'
    AND
    dmINVTBL.ITEMTYPE <> '2'
    AND
    dmINVTBL.HPLBUSINESSRULESTATUSID NOT IN ('0000.NEW ITEM', '9999.NOT ACTIVE')
    AND
    LEFT(dmINVTBL.ITEMID,4) <> '9910'
    AND
    dmINVTBL.HPLSTATISTICGROUPID <> 'YYYY'
),
CQtySOInBU AS(
SELECT
        DATAAREAID
    ,   PlantID
    ,   INVENTLOCATIONID
    ,   MaterialID
    ,   GoodsMovementTypeID
    ,   TRANSTYPENAME
    ,   SUM(MatlStkChangeQtyInBaseUnit) as ConsumptionQtySOInBaseUnit
FROM
    INVTRANS
WHERE
    GoodsMovementTypeID = '1'
GROUP BY
        DATAAREAID
    ,   PlantID
    ,   INVENTLOCATIONID
    ,   MaterialID
    ,   GoodsMovementTypeID
    ,   TRANSTYPENAME
),
CQtyOBDProInBU AS(
SELECT
        DATAAREAID
    ,   PlantID
    ,   INVENTLOCATIONID
    ,   MaterialID
    ,   GoodsMovementTypeID
    ,   TRANSTYPENAME
    ,   SUM(MatlStkChangeQtyInBaseUnit) as ConsumptionQtyOBDProInBaseUnit
FROM
    INVTRANS
WHERE
    GoodsMovementTypeID = '2'
GROUP BY
        DATAAREAID
    ,   PlantID
    ,   INVENTLOCATIONID
    ,   MaterialID
    ,   GoodsMovementTypeID
    ,   TRANSTYPENAME
),
CQtyOICPInBU AS(
SELECT
        INVT.DATAAREAID
    ,   PlantID
    ,   INVENTLOCATIONID
    ,   INVT.MaterialID
    ,   GoodsMovementTypeID
    ,   TRANSTYPENAME
    ,   SUM(MatlStkChangeQtyInBaseUnit) as ConsumptionQtyICPOInBaseUnit
FROM
    INVTRANS INVT
LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_PURCHLINE] FP
        ON
        FP.[INVENTDIMID] = INVT.[MaterialDocument]
        AND
        INVT.[MaterialID] = FP.[ITEMID]
        AND
        INVT.[INVENTTRANSID] = FP.[INVENTTRANSID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[DIM_VENDTABLE] dmVend
        ON
        FP.[VENDACCOUNT] = dmVend.[ACCOUNTNUM]
WHERE
    INVT.GoodsMovementTypeID = '3'
    AND
    dmVend.[ACCOUNTNUM] = '200'
GROUP BY
        INVT.DATAAREAID
    ,   PlantID
    ,   INVENTLOCATIONID
    ,   INVT.MaterialID
    ,   GoodsMovementTypeID
    ,   TRANSTYPENAME
),
AvgPricePerUnit AS(
SELECT
        [MaterialID]
    ,   [PlantID]
    ,   [DATAAREAID]
    ,   SUM(MatlStkChangeQtyInBaseUnit)/SUM([CostAmount_Total]) as AvgPrice
FROM
    INVTRANS INVT
GROUP BY
        [MaterialID]
    ,   [PlantID]
    ,   [DATAAREAID]
),
EuroExchangeRate AS (
    SELECT 
        SourceCurrency
        ,ExchangeRateEffectiveDate
        ,ExchangeRate
    FROM 
        edw.dim_ExchangeRates
    WHERE
        ExchangeRateType = 'ZAXBIBUD'
        and
        TargetCurrency = 'EUR'
),
ExchangeRateEuro as (
    SELECT
            [MaterialDocument]
        ,   [MaterialDocumentItem]
        ,   EuroExchangeRate.[ExchangeRate] AS [ExchangeRate]
    FROM (
        SELECT
                [MaterialDocument]
            ,   [MaterialDocumentItem]
            ,   [CompanyCodeCurrency] COLLATE Latin1_General_100_BIN2 AS [CompanyCodeCurrency]
            ,   MAX([ExchangeRateEffectiveDate]) as [ExchangeRateEffectiveDate]
        FROM 
            INVTRANS INV
        LEFT JOIN 
            EuroExchangeRate
            ON 
                INV.[CompanyCodeCurrency] COLLATE Latin1_General_100_BIN2 = EuroExchangeRate.SourceCurrency
        WHERE 
            [ExchangeRateEffectiveDate] <= [DocumentDate]
        GROUP BY
                [MaterialDocument]
            ,   [MaterialDocumentItem]
            ,   [CompanyCodeCurrency] 
    ) inv_er_date_eur
    LEFT JOIN 
        EuroExchangeRate
        ON
            inv_er_date_eur.[CompanyCodeCurrency] = EuroExchangeRate.[SourceCurrency]
            AND
            inv_er_date_eur.[ExchangeRateEffectiveDate] = EuroExchangeRate.[ExchangeRateEffectiveDate]
),
INVTRANS_QTY AS(
SELECT
        INV.[MaterialDocumentYear]
    ,   ExchangeRateEuro.[MaterialDocument]
    ,   ExchangeRateEuro.[MaterialDocumentItem]
    ,   INV.[MaterialID]
    ,   INV.[PlantID]
    ,   dmInvLocation.[INVENTLOCATIONID] AS [StorageLocationID]
    ,   INV.[SalesOrder]
    ,   INV.[SalesOrderItem]
    ,   INV.[GoodsMovementTypeID]
    ,   INV.[GoodsMovementTypeName]
    ,   SU.[target_Unit] AS [MaterialBaseUnitID]
    ,   INV.[HDR_PostingDate]
    ,   INV.[DocumentDate]
    ,   INV.[CompanyCodeCurrency]
    ,   INV.[PurchaseOrder]
    ,   INV.[PurchaseOrderItem]
    ,   INV.[Order]
    ,   INV.[OrderItem]
    ,   INV.[DeliveryDocument]
    ,   INV.[DeliveryDocumentItem]
    ,   INV.[SalesDocumentItemCategoryID]    
    ,   CASE
            WHEN INV.[GoodsMovementTypeID] = '0'
            THEN vwSDDC.[SDDocumentCategory]
            ELSE NULL
        END                           AS [SalesDocumentItemCategory]
    ,   INV.[MatlStkChangeQtyInBaseUnit]
    ,   QtySO.[ConsumptionQtySOInBaseUnit] AS [ConsumptionQtySOInBaseUnit]
    ,   QtyOBD.[ConsumptionQtyOBDProInBaseUnit] AS [ConsumptionQtyOBDProInBaseUnit]
    ,   QtyOICP.[ConsumptionQtyICPOInBaseUnit] AS [ConsumptionQtyICPOInBaseUnit]
    ,   INV.[MatlCnsmpnQtyInMatlBaseUnit]
    ,   INV.[ManufacturingOrder]
    ,   INV.[ManufacturingOrderItem]
    ,   INV.[PriceControlIndicatorID]
    ,   INV.[PriceControlIndicator]
    ,   '10' AS [CurrencyTypeID]
    ,   APU.AvgPrice AS [StandardPricePerUnit]
    ,   CASE 
            WHEN [CompanyCodeCurrency]='EUR' THEN APU.AvgPrice
            ELSE APU.AvgPrice*ExchangeRateEuro.ExchangeRate
        END AS [StandardPricePerUnit_EUR]
    ,   INV.[t_applicationId]
    ,   INV.[t_extractionDtm]
FROM
    ExchangeRateEuro
LEFT JOIN
    INVTRANS AS INV
    ON
        INV.MaterialDocument = ExchangeRateEuro.MaterialDocument
        AND
        INV.MaterialDocumentItem = ExchangeRateEuro.MaterialDocument        
LEFT JOIN
    [edw].[vw_SDDocumentCategory] vwSDDC
    ON 
        INV.[SalesDocumentItemCategoryID] = vwSDDC.SDDocumentCategoryID
LEFT JOIN
    [base_tx_halfen_2_dwh].[DIM_INVENTLOCATION] dmInvLocation
        ON
        dmInvLocation.[INVENTLOCATIONID] = INV.[INVENTLOCATIONID]
LEFT JOIN
    map_AXBI.[StockUnit] SU
        ON
        INV.[StockUnit] = SU.[target_UnitID]
LEFT JOIN
    AvgPricePerUnit APU
        ON
        APU.[MaterialID] =  INV.[MaterialID]
        AND
        APU.[PlantID] = INV.[PlantID]
        AND
        APU.[DATAAREAID] = INV.[DATAAREAID]
LEFT JOIN
    CQtySOInBU QtySO
        ON 
        QtySO.[DATAAREAID] = INV.[DATAAREAID]
        AND
        QtySO.[PlantID] = INV.[PlantID]
        AND
        QtySO.[INVENTLOCATIONID] = INV.[INVENTLOCATIONID]
        AND
        QtySO.[MaterialID] = INV.[MaterialID]
        AND
        QtySO.[GoodsMovementTypeID] = INV.[GoodsMovementTypeID]
        AND
        QtySO.[TRANSTYPENAME] = INV.[GoodsMovementTypeName]
LEFT JOIN
    CQtyOBDProInBU QtyOBD
        ON 
        QtyOBD.[DATAAREAID] = INV.[DATAAREAID]
        AND
        QtyOBD.[PlantID] = INV.[PlantID]
        AND
        QtyOBD.[INVENTLOCATIONID] = INV.[INVENTLOCATIONID]
        AND
        QtyOBD.[MaterialID] = INV.[MaterialID]
        AND
        QtyOBD.[GoodsMovementTypeID] = INV.[GoodsMovementTypeID]
        AND
        QtyOBD.[TRANSTYPENAME] = INV.[GoodsMovementTypeName]
LEFT JOIN
    CQtyOICPInBU QtyOICP
        ON 
        QtyOICP.[DATAAREAID] = INV.[DATAAREAID]
        AND
        QtyOICP.[PlantID] = INV.[PlantID]
        AND
        QtyOICP.[INVENTLOCATIONID] = INV.[INVENTLOCATIONID]
        AND
        QtyOICP.[MaterialID] = INV.[MaterialID]
        AND
        QtyOICP.[GoodsMovementTypeID] = INV.[GoodsMovementTypeID]
        AND
        QtyOICP.[TRANSTYPENAME] = INV.[GoodsMovementTypeName]
)
SELECT
        INV_QTY.[MaterialDocumentYear]
    ,   INV_QTY.[MaterialDocument]
    ,   INV_QTY.[MaterialDocumentItem]
    ,   INV_QTY.[MaterialID]
    ,   INV_QTY.[PlantID]
    ,   INV_QTY.[StorageLocationID]
    ,   INV_QTY.[SalesOrder]
    ,   INV_QTY.[SalesOrderItem]
    ,   INV_QTY.[GoodsMovementTypeID]
    ,   INV_QTY.[GoodsMovementTypeName]
    ,   INV_QTY.[MaterialBaseUnitID]
    ,   INV_QTY.[HDR_PostingDate]
    ,   INV_QTY.[DocumentDate]
    ,   INV_QTY.[CompanyCodeCurrency]
    ,   INV_QTY.[PurchaseOrder]
    ,   INV_QTY.[PurchaseOrderItem]
    ,   INV_QTY.[Order]
    ,   INV_QTY.[OrderItem]
    ,   INV_QTY.[DeliveryDocument]
    ,   INV_QTY.[DeliveryDocumentItem]
    ,   INV_QTY.[SalesDocumentItemCategoryID]
    ,   INV_QTY.[SalesDocumentItemCategory]
    ,   INV_QTY.[MatlStkChangeQtyInBaseUnit]
    ,   INV_QTY.[ConsumptionQtySOInBaseUnit]
    ,   INV_QTY.[ConsumptionQtyOBDProInBaseUnit]
    ,   INV_QTY.[MatlCnsmpnQtyInMatlBaseUnit]
    ,   INV_QTY.[ManufacturingOrder]
    ,   INV_QTY.[ManufacturingOrderItem]
    ,   INV_QTY.[PriceControlIndicatorID]
    ,   INV_QTY.[PriceControlIndicator]
    ,   INV_QTY.[CurrencyTypeID]
    ,   INV_QTY.[StandardPricePerUnit]
    ,   INV_QTY.[StandardPricePerUnit_EUR]
    ,   INV_QTY.[StandardPricePerUnit]*INV_QTY.[ConsumptionQtyICPOInBaseUnit] AS [ConsumptionQtyICPOInStandardValue]
    ,   INV_QTY.[ConsumptionQtyICPOInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [ConsumptionQtyICPOInStandardValue_EUR]
    ,   INV_QTY.[ConsumptionQtySOInBaseUnit]*INV_QTY.[StandardPricePerUnit] AS [ConsumptionQtySOStandardValue]
    ,   INV_QTY.[ConsumptionQtySOInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [ConsumptionQtySOStandardValue_EUR]
    ,   INV_QTY.[MatlStkChangeQtyInBaseUnit]*INV_QTY.[StandardPricePerUnit] AS [MatlStkChangeStandardValue]
    ,   INV_QTY.[MatlStkChangeQtyInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [MatlStkChangeStandardValue_EUR]
    ,   INV_QTY.[ConsumptionQtyOBDProInBaseUnit]*INV_QTY.[StandardPricePerUnit] AS [ConsumptionQtyProStandardValue]
    ,   INV_QTY.[ConsumptionQtyOBDProInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [ConsumptionQtyProStandardValue_EUR]
    ,   INV_QTY.[t_applicationId]
    ,   INV_QTY.[t_extractionDtm]
FROM
    INVTRANS_QTY AS INV_QTY


