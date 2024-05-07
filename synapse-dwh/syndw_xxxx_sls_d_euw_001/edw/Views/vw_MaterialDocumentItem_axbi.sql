CREATE VIEW [edw].[vw_MaterialDocumentItem_axbi]
	AS 
WITH INVTRANS AS
(
SELECT
        YEAR(FINV.[DATEPHYSICAL])     AS [MaterialDocumentYear]
    ,   FINV.[INVENTDIMID]            AS [MaterialDocument]
    ,   FINV.[RECID]                  AS [MaterialDocumentItem]
    ,   CASE
            WHEN SINMT.[SAPProductID] IS NULL
            THEN CONCAT('HALF','-',FINV.[ITEMID])
            ELSE SINMT.[SAPProductID] --Changed to SAPProductID as the Product Dimension uses leading zero's.
        END                           AS [MaterialID]
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
    ,   'MDOC'                        AS [MaterialDocumentRecordType]
    ,   FINV.[t_applicationId]
    ,   FINV.[t_extractionDtm]
FROM
    intm_axbi.vw_FACT_INVENTTRANS FINV
LEFT JOIN
    [edw].[dim_SAPItemNumberBasicMappingTable] SINMT 
    ON
        FINV.[ITEMID] = SINMT.[AXItemnumber]
        AND
        [AXDataAreaId] = '0000' --Halfen entities are mapped with Data Area '0000'.
        AND
        SINMT.[SAPProductID] IS NOT NULL
LEFT JOIN
 [base_tx_halfen_2_dwh].[DIM_INVENTDIM] dmINV
    ON
        dmINV.[INVENTDIMID] = FINV.[INVENTDIMID]
LEFT JOIN
    intm_axbi.vw_FACT_SALESLINE SL
    ON
        FINV.[INVENTTRANSID] = SL.[INVENTTRANSID]
LEFT JOIN
    [base_tx_halfen_2_dwh].[DIM_ADUENUMTRANSLATIONS] dmATRNS
    ON
        dmATRNS.[ENUMVALUE] = FINV.[TRANSTYPE]
LEFT JOIN
    intm_axbi.vw_DIM_INVENTTABLE dmINVTBL
    ON
        FINV.[ITEMID] = dmINVTBL.[ITEMID]
        AND 
        FINV.[DATAAREAID] = dmINVTBL.[DATAAREAID]
LEFT JOIN
    [base_dw_halfen_1_stg].[AX_Halfen_dbo_COMPANYINFO] AX_Cmpny
    ON
        FINV.[DATAAREAID] = AX_Cmpny.[DATAAREAID]
LEFT JOIN
    intm_axbi.vw_FACT_PURCHLINE FPURL
    ON
        FINV.[INVENTTRANSID] = FPURL.[INVENTTRANSID]
LEFT JOIN
    intm_axbi.vw_FACT_PRODJOURNALPROD FPJRNL
    ON
        FINV.[INVENTTRANSID] = FPJRNL.[INVENTTRANSID]
        AND
        FINV.[INVENTDIMID] = FPJRNL.[INVENTDIMID]
WHERE
    (FINV.[STATUSRECEIPT] in ('1','2')
    OR
    FINV.[STATUSISSUE] in ('1','2'))
    AND
    FINV.[DATEPHYSICAL]<>''
    AND
    dmINV.[INVENTSITEID] NOT LIKE '%D%'
    AND 
    dmATRNS.[ENUMID] = '107'
    AND
    dmINVTBL.[ITEMTYPE] <> '2'
    AND
    dmINVTBL.[HPLBUSINESSRULESTATUSID] NOT IN ('0000.NEW ITEM', '9999.NOT ACTIVE')
    AND
    LEFT(dmINVTBL.[ITEMID],4) <> '9910'
    AND
    dmINVTBL.[HPLSTATISTICGROUPID] <> 'YYYY'
    AND
    FINV.DATEFINANCIAL<>'1900-01-01'
    AND
    FINV.DATEPHYSICAL<>'1900-01-01'
),
CQtySOInBU AS(
SELECT 
        [DATAAREAID]
    ,   [PlantID]
    ,   [INVENTLOCATIONID]
    ,   [MaterialID]
    ,   [GoodsMovementTypeID]
    ,   [TRANSTYPENAME]
    ,   SUM([MatlStkChangeQtyInBaseUnit]) as [ConsumptionQtySOInBaseUnit]
FROM
    INVTRANS
WHERE
    [GoodsMovementTypeID] = '0'
GROUP BY
        [DATAAREAID]
    ,   [PlantID]
    ,   [INVENTLOCATIONID]
    ,   [MaterialID]
    ,   [GoodsMovementTypeID]
    ,   [TRANSTYPENAME]
),
CQtyOBDProInBU AS(
SELECT  
        [DATAAREAID]
    ,   [PlantID]
    ,   [INVENTLOCATIONID]
    ,   [MaterialID]
    ,   [GoodsMovementTypeID]
    ,   [TRANSTYPENAME]
    ,   SUM([MatlStkChangeQtyInBaseUnit]) as [ConsumptionQtyOBDProInBaseUnit]
FROM
    INVTRANS
WHERE
    [GoodsMovementTypeID] = '2'
GROUP BY
        [DATAAREAID]
    ,   [PlantID]
    ,   [INVENTLOCATIONID]
    ,   [MaterialID]
    ,   [GoodsMovementTypeID]
    ,   [TRANSTYPENAME]
),
CQtyOICPInBU AS(
SELECT
        INVT.[DATAAREAID]
    ,   [PlantID]
    ,   [INVENTLOCATIONID]
    ,   INVT.[MaterialID]
    ,   [GoodsMovementTypeID]
    ,   [TRANSTYPENAME]
    ,   SUM([MatlStkChangeQtyInBaseUnit]) as [ConsumptionQtyICPOInBaseUnit]
FROM
    INVTRANS INVT
LEFT JOIN
    intm_axbi.vw_FACT_PURCHLINE FP
        ON
        INVT.[INVENTTRANSID] = FP.[INVENTTRANSID]
LEFT JOIN 
    intm_axbi.vw_DIM_VENDTABLE dmVend
        ON
        FP.[VENDACCOUNT] = CAST(dmVend.[ACCOUNTNUM] AS NVARCHAR(20))
        AND
        FP.[DATAAREAID] = dmVend.[DATAAREAID]
WHERE
    INVT.[GoodsMovementTypeID] = '3'
    AND
    dmVend.[VENDGROUP] = '200'
GROUP BY
        INVT.[DATAAREAID]
    ,   [PlantID]
    ,   [INVENTLOCATIONID]
    ,   INVT.[MaterialID]
    ,   [GoodsMovementTypeID]
    ,   [TRANSTYPENAME]
),
AvgPricePerUnit AS(
SELECT
        [MaterialID]
    ,   [PlantID]
    ,   [DATAAREAID]    
    ,   CASE
            WHEN ISNULL(SUM([CostAmount_Total]),0) != 0
            THEN SUM([MatlStkChangeQtyInBaseUnit])/SUM([CostAmount_Total])
            ELSE 0
        END AS [AvgPrice]
FROM
    INVTRANS INVT
WHERE
    [GoodsMovementTypeID] IN ('13','2','8','3','6','22','21')
    AND
    [MatlStkChangeQtyInBaseUnit] > 0
GROUP BY
        [MaterialID]
    ,   [PlantID]
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
    ,   INV.[DATAAREAID]
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
            ELSE APU.AvgPrice*CCR.ExchangeRate
        END AS [StandardPricePerUnit_EUR]
    ,   INV.[t_applicationId]
    ,   INV.[MaterialDocumentRecordType]
    ,   INV.[t_extractionDtm]
FROM
    INVTRANS AS INV
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON 
        INV.CompanyCodeCurrency = CCR.SourceCurrency  
LEFT JOIN 
    [edw].[dim_CurrencyType] CR
    ON 
        CCR.CurrencyTypeID = CR.CurrencyTypeID
LEFT JOIN
    [edw].[dim_SDDocumentCategory] vwSDDC
    ON 
        INV.[SalesDocumentItemCategoryID] = vwSDDC.SDDocumentCategoryID
LEFT JOIN
    intm_axbi.vw_DIM_INVENTLOCATION dmInvLocation
        ON
        dmInvLocation.[INVENTLOCATIONID] = INV.[INVENTLOCATIONID]
LEFT JOIN
    map_AXBI.[StockUnit] SU
        ON
        INV.[StockUnit] = SU.[source_UnitID]
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
LEFT JOIN                                                           -- Migration reference was joined to exclude unnecessary data from migrated systems
    [map_AXBI].[Migration] AXM
        ON
        INV.[DATAAREAID] = AXM.[DataAreaID]
WHERE
    INV.[DocumentDate] < COALESCE (AXM.MigrationDate,'9999-12-31')
)
SELECT  DISTINCT
        INV_QTY.[MaterialDocumentYear]
    ,   INV_QTY.[MaterialDocument]
    ,   INV_QTY.[MaterialDocumentItem]
    ,   INV_QTY.[MaterialID]
    ,   INV_QTY.[PlantID]
    ,   INV_QTY.[StorageLocationID]
    ,   INV_QTY.[DATAAREAID] AS axbi_DataAreaID
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
    ,   INV_QTY.[SalesDocumentItemCategoryID]
    ,   INV_QTY.[SalesDocumentItemCategory]
    ,   INV_QTY.[StandardPricePerUnit]
    ,   INV_QTY.[StandardPricePerUnit_EUR]
    ,   INV_QTY.[PriceControlIndicatorID]
    ,   INV_QTY.[PriceControlIndicator]
    ,   INV_QTY.[StandardPricePerUnit]*INV_QTY.[ConsumptionQtyICPOInBaseUnit] AS [ConsumptionQtyICPOInStandardValue]
    ,   INV_QTY.[ConsumptionQtyICPOInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [ConsumptionQtyICPOInStandardValue_EUR]
    ,   INV_QTY.[ConsumptionQtySOInBaseUnit]*INV_QTY.[StandardPricePerUnit] AS [ConsumptionQtySOStandardValue]
    ,   INV_QTY.[ConsumptionQtySOInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [ConsumptionQtySOStandardValue_EUR]
    ,   INV_QTY.[MatlStkChangeQtyInBaseUnit]*INV_QTY.[StandardPricePerUnit] AS [MatlStkChangeStandardValue]
    ,   INV_QTY.[MatlStkChangeQtyInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [MatlStkChangeStandardValue_EUR]
    ,   INV_QTY.[ConsumptionQtyOBDProInBaseUnit]*INV_QTY.[StandardPricePerUnit] AS [ConsumptionQtyProStandardValue]
    ,   INV_QTY.[ConsumptionQtyOBDProInBaseUnit]*INV_QTY.[StandardPricePerUnit_EUR] AS [ConsumptionQtyProStandardValue_EUR]
    ,   INV_QTY.[CurrencyTypeID]
    ,   INV_QTY.[MatlStkChangeQtyInBaseUnit]
    ,   INV_QTY.[ConsumptionQtyICPOInBaseUnit]
    ,   INV_QTY.[ConsumptionQtyOBDProInBaseUnit]
    ,   INV_QTY.[ConsumptionQtySOInBaseUnit]
    ,   INV_QTY.[MatlCnsmpnQtyInMatlBaseUnit]
    ,   INV_QTY.[ManufacturingOrder]
    ,   INV_QTY.[ManufacturingOrderItem]
    ,   INV_QTY.[MaterialDocumentRecordType]
    ,   INV_QTY.[t_applicationId]
    ,   INV_QTY.[t_extractionDtm]
FROM
    INVTRANS_QTY AS INV_QTY