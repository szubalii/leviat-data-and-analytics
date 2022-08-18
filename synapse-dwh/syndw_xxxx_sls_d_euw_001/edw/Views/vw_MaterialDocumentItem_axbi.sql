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
    ,   dmINVTBL.[StockUnit]
    ,   FINV.[DATEPHYSICAL]           AS [HDR_PostingDate]
    ,   FINV.[DATEPHYSICAL]           AS [DocumentDate]
    ,   dmSO.[SalesOrganizationCurrency]               AS [CompanyCodeCurrency]
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
                                    WHEN SL.[OrderQuantity] > 0 THEN 'L'
                                    WHEN SL.[OrderQuantity] < 0 THEN 'K'
                                END
                        END
                END
        END                           AS [SalesDocumentItemCategoryID]
    ,   CASE
            WHEN FINV.[TRANSTYPE] = '0'
            THEN vwSDDC.[SDDocumentCategory]
            ELSE NULL
        END                           AS [SalesDocumentItemCategory]
    ,   FINV.[QTY]                    AS [MatlStkChangeQtyInBaseUnit]
    ,   [QTY]                    AS [MatlCnsmpnQtyInMatlBaseUnit]
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
    ,   [t_applicationId]
    ,   [t_extractionDtm]
FROM
    [base_tx_halfen_2_dwh].[FACT_INVENTTRANS] FINV
LEFT JOIN
    [edw].[dim_SAPItemNumberBasicMappingTable] SINMT 
    ON
        FINV.[ITEMID] = SINMT.AXItemnumber
        AND
        SINMT.[Migrate] IN ('Y', 'D')
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
    [edw].[dim_SalesOrganization] dmSO
    ON
        FINV.[DATAAREAID] = dmSO.[SalesOrganizationID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_PURCHLINE] FPURL
    ON
        FINV.[INVENTRANSID] = FPURL.[INVENTRANSID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_PRODJOURNALPROD] FPJRNL
    ON
        FINV.[INVENTRANSID] = FPJRNL.[INVENTRANSID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_CUSTPACKINGSLIPTRANS] FCPLT
    ON
        FINV.[INVENTRANSID] = FCPLT.[INVENTRANSID]
LEFT JOIN
    [edw].[vw_SDDocumentCategory] vwSDDC
    ON 
        FINV.SalesDocumentItemCategoryID = vwSDDC.SDDocumentCategoryID
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
    LEFT(CdmINVTBL.ITEMID,4) <> '9910'
    AND
    dmINVTBL.HPLSTATISTICGROUPID <> 'YYYY'
),
CQtySOInBU AS(
SELECT
        DATAAREAID
    ,   INVENTSITEID
    ,   INVENTLOCATIONID
    ,   ITEMID
    ,   TRANSTYPE
    ,   TRANSTYPENAME
    ,   SUM(QTY) as ConsumptionQtySOInBaseUnit
FROM
    [base_tx_halfen_2_dwh].[FACT_INVENTTRANS]
WHERE
    TRANSTYPE = '1'
GROUP BY
        DATAAREAID
    ,   INVENTSITEID
    ,   INVENTLOCATIONID
    ,   ITEMID
    ,   TRANSTYPE
    ,   TRANSTYPENAME
),
CQtyOBDProInBU AS(
SELECT
        DATAAREAID
    ,   INVENTSITEID
    ,   INVENTLOCATIONID
    ,   ITEMID
    ,   TRANSTYPE
    ,   TRANSTYPENAME
    ,   SUM(QTY) as ConsumptionQtyOBDProInBaseUnit
FROM
    [base_tx_halfen_2_dwh].[FACT_INVENTTRANS]
WHERE
    TRANSTYPE = '2'
GROUP BY
        DATAAREAID
    ,   INVENTSITEID
    ,   INVENTLOCATIONID
    ,   ITEMID
    ,   TRANSTYPE
    ,   TRANSTYPENAME
),
CQtyOICPInBU AS(
SELECT
        DATAAREAID
    ,   INVENTSITEID
    ,   INVENTLOCATIONID
    ,   ITEMID
    ,   TRANSTYPE
    ,   TRANSTYPENAME
    ,   SUM(QTY) as ConsumptionQtyICPOInBaseUnit
FROM
    [base_tx_halfen_2_dwh].[FACT_INVENTTRANS] FI
LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_PURCHLINE] FP
        ON
        FP.[INVENTDIMID] = FI.[INVENTDIMID]
        AND
        FI.[ITEMID] = FP.[ITEMID]
        AND
        FI.[INVENTSITEID] = FI.[INVENTSITEID]

LEFT JOIN
    [base_tx_halfen_2_dwh].[FACT_PURCHLINE] FP
        ON
        FP.[INVENTDIMID] = FI.[INVENTDIMID]
        AND
        FI.[ITEMID] = FP.[ITEMID]
        AND
        FI.[INVENTSITEID] = FI.[INVENTSITEID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[DIM_VENDTABLE] dmVend
        ON
        FP.[VENDACCOUNT] = dmVend.[ACCOUNTNUM]
WHERE
    FI.TRANSTYPE = '3'
    AND
    dmVend.[ACCOUNTNUM] = '200'
GROUP BY
        DATAAREAID
    ,   INVENTSITEID
    ,   INVENTLOCATIONID
    ,   ITEMID
    ,   TRANSTYPE
    ,   TRANSTYPENAME
),
AvgPricePerUnit AS(
SELECT
        [ITEMID]
    ,   [INVENTSITEID]
    ,   [DATAAREAID]
    ,   SUM(QTY)/SUM([CostAmount_Total]) as AvgPrice
FROM
    [base_tx_halfen_2_dwh].[FACT_INVENTTRANS] FINV    
GROUP BY
        [ITEMID]
    ,   [INVENTSITEID]
    ,   [DATAAREAID]
),
INVTRANS_QTY AS(
SELECT

        INV.[MaterialDocumentYear]
    ,   INV.[MaterialDocument]
    ,   INV.[MaterialDocumentItem]
    ,   INV.[MaterialID]
    ,   INV.[PlantID]
    ,   dmInvLocation.[INVENTLOCATIONID] AS [StorageLocationID]
    ,   INV.[SalesOrder]
    ,   INV.[SalesOrderItem]
    ,   INV.[GoodsMovementTypeID]
    ,   INV.[GoodsMovementTypeName]
    ,   SU.[SAPUoM] AS [MaterialBaseUnitID]
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
    ,   INV.[SalesDocumentItemCategory]
    ,   INV.[MatlStkChangeQtyInBaseUnit]
    ,   QtySO.[ConsumptionQtySOInBaseUnit] AS [ConsumptionQtySOInBaseUnit]
    ,   QtyOBD.[ConsumptionQtyOBDProInBaseUnit] AS [ConsumptionQtyOBDProInBaseUnit]
    ,   CQtyOICPInBU.[ConsumptionQtyICPOInBaseUnit] AS [ConsumptionQtyICPOInBaseUnit]
    ,   INV.[MatlCnsmpnQtyInMatlBaseUnit]
    ,   INV.[ManufacturingOrder]
    ,   INV.[ManufacturingOrderItem]
    ,   INV.[PriceControlIndicatorID]
    ,   INV.[PriceControlIndicator]
    ,   APU.AvgPrice AS [StandardPricePerUnit]
    ,   NULL AS [StandardPricePerUnit_EUR]
    ,   INV.[t_applicationId]
    ,   INV.[t_extractionDtm]
FROM
    INVTRANS AS INV
LEFT JOIN
    [base_tx_halfen_2_dwh].[DIM_INVENTLOCATION] dmInvLocation
        ON
        dmInvLocation.[INVENTLOCATIONID] = INV.[INVENTLOCATIONID]
LEFT JOIN
    map_AXBI.[StockUnit] SU
        ON
        INV.[StockUnit] = SU.[SAPUnit]
LEFT JOIN
    AvgPricePerUnit APU
        ON
        APU.[ITEMID] =  INV.[MaterialID]
        AND
        APU.[INVENTSITEID] = INV.[PlantID]
        AND
        APU.[DATAAREAID] = INV.[DATAAREAID]
LEFT JOIN
    CQtySOInBU QtySO
        ON 
        QtySO.[DATAAREAID] = INV.[DATAAREAID]
        AND
        QtySO.[INVENTSITEID] = INV.[PlantID]
        AND
        QtySO.[INVENTLOCATIONID] = INV.[INVENTLOCATIONID]
        AND
        QtySO.[ITEMID] = INV.[MaterialID]
        AND
        QtySO.[TRANSTYPE] = INV.[GoodsMovementTypeID]
        AND
        QtySO.[TRANSTYPENAME] = INV.[GoodsMovementTypeName]
LEFT JOIN
    CQtyOBDProInBU QtyOBD
        ON 
        QtyOBD.[DATAAREAID] = INV.[DATAAREAID]
        AND
        QtyOBD.[INVENTSITEID] = INV.[PlantID]
        AND
        QtyOBD.[INVENTLOCATIONID] = INV.[INVENTLOCATIONID]
        AND
        QtyOBD.[ITEMID] = INV.[MaterialID]
        AND
        QtyOBD.[TRANSTYPE] = INV.[GoodsMovementTypeID]
        AND
        QtyOBD.[TRANSTYPENAME] = INV.[GoodsMovementTypeName]
LEFT JOIN
    CQtyOICPInBU QtyOICP
        ON 
        QtyOICP.[DATAAREAID] = INV.[DATAAREAID]
        AND
        QtyOICP.[INVENTSITEID] = INV.[PlantID]
        AND
        QtyOICP.[INVENTLOCATIONID] = INV.[INVENTLOCATIONID]
        AND
        QtyOICP.[ITEMID] = INV.[MaterialID]
        AND
        QtyOICP.[TRANSTYPE] = INV.[GoodsMovementTypeID]
        AND
        QtyOICP.[TRANSTYPENAME] = INV.[GoodsMovementTypeName]
),
INVTRANS_CALCS AS(
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
    ,   INV_QTY.[StandardPricePerUnit]
    ,   INV_QTY.[StandardPricePerUnit_EUR]
    ,   INV_QTY.[StandardPricePerUnit]*INV_QTY.[ConsumptionQtyICPOInBaseUnit] AS [ConsumptionQtyICPOInStandardValue]
    ,   INV_QTY.[ConsumptionQtyICPOInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [ConsumptionQtyICPOInStandardValue_EUR]
    ,   INV_QTY.[ConsumptionQtySOInBaseUnit]*INV_QTY.[StandardPricePerUnitAS] AS [ConsumptionQtySOStandardValue]
    ,   INV_QTY.[ConsumptionQtySOInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [ConsumptionQtySOStandardValue_EUR]
    ,   INV_QTY.[MatlStkChangeQtyInBaseUnit]*INV_QTY.[StandardPricePerUnit] AS [MatlStkChangeStandardValue]
    ,   INV_QTY.[MatlStkChangeQtyInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [MatlStkChangeStandardValue_EUR]
    ,   INV_QTY.[ConsumptionQtyOBDProInBaseUnit]*INV_QTY.[StandardPricePerUnit] AS [ConsumptionQtyProStandardValue]
    ,   INV_QTY.[ConsumptionQtyOBDProInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [ConsumptionQtyProStandardValue_EUR]
    ,   INV_QTY.[t_applicationId]
    ,   INV_QTY.[t_extractionDtm]
FROM
    INVTRANS_QTY AS INV_QTY
),
SELECT * FROM INVTRANS_CALCS


