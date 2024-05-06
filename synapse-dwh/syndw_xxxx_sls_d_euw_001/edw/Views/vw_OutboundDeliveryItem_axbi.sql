CREATE VIEW [edw].[vw_OutboundDeliveryItem_axbi]
	AS 
SELECT
    CONCAT_WS('¦', FCust.[PACKINGSLIPID] /*collate SQL_Latin1_General_CP1_CS_AS*/, FCust.[INVENTTRANSID] /*collate SQL_Latin1_General_CP1_CS_AS*/) as [nk_fact_OutboundDeliveryItem],
	FCust.[PACKINGSLIPID]                                                        as [OutboundDelivery],
    SO.[target_SalesOrganizationID]                                              as [HDR_SalesOrganizationID], 
    FCust.[ORIGSALESID]                                                          as [ReferenceSDDocument],
    FCust.[DELIVERYDATE]                                                         as [HDR_DeliveryDate], 
    FCust.[INVENTTRANSID]                                                        as [ReferenceSDDocumentItem], --INVENTTRANSID
    RIGHT('000000000000000000' + mapMaterial.[target_Material], 18)              as [ProductID],
    DimCust.[CustomerID]                                                         as [HDR_SoldToPartyID],
    FCust.[CURRENCYCODE_CZ]                                                      as [SDI_LocalCurrency],
    FCust.[SHIPPINGDATEREQUESTED]                                                as [SDI_RequestedDeliveryDate],
    FCust.[SHIPPINGDATECONFIRMED_tf]                                             as [SL_ConfirmedDeliveryDate],
    NULL                                                                         as [PlantId], -- FCust.[INVENTSITEID],
    NULL                                                                         as [WarehouseId], -- FCust.[INVENTLOCATIONID],
    
    format((row_number()  
    over (partition by FCust.[PACKINGSLIPID] 
    order by FCust.[DELIVERYDATE]))*10,'000000')                                 as [OutboundDeliveryItem], --INVENTTRANSID

    FCust.[QTY]                                                                  as [ActualDeliveryQuantity],
    case when 
         FCust.[QTY] > 0 
    then FCust.[HPLCOSTPRICE] / FCust.[QTY]                       
    else 0 end                                                                   as [SDI_PricePerPiece_LC],

    case
    when FCust.[DATAAREAID] = FSL.[DATAAREAID]
        and
        FCust.[ORIGSALESID] = FSL.[SALESID]
        and
        FCust.[INVENTTRANSID] = FSL.[INVENTTRANSID]
        then FSL.[SALESQTY]
    else 0 end                                                                   as SL_ConfdOrderQtyByMatlAvailCheck,

    case
    when FCust.[DELIVERYDATE] = FCust.[SHIPPINGDATECONFIRMED_tf]
        then 1
    else 0
    end
                                                                                 as [IsOnTimeDelivery],
    case
    when FSL.[SALESQTY] = FCust.[QTY]
        then 1
    else 0
    end                                                                          as [IsInFull],

    case
    when FCust.[DELIVERYDATE] < FCust.[SHIPPINGDATECONFIRMED_tf]
        then DATEDIFF(day, FCust.[DELIVERYDATE], FCust.[SHIPPINGDATECONFIRMED_tf])
    else 0
    end                                                                         as [DeliveredEarlyDays],

    case
    when FCust.[DELIVERYDATE] > FCust.[SHIPPINGDATECONFIRMED_tf]
        then DATEDIFF(day, FCust.[DELIVERYDATE], FCust.[SHIPPINGDATECONFIRMED_tf])   
    else 0
    end                                                                        as [DeliveredLateDays],

    case
    when FCust.[DELIVERYDATE] < FCust.[SHIPPINGDATECONFIRMED_tf]
        then 1
    else 0
    end                                                                      as [IsEarlyDelivered],
    case
    when FCust.[DELIVERYDATE] > FCust.[SHIPPINGDATECONFIRMED_tf]
        then 1
    else 0
    end                                                                      as [IsLateDelivered],

    FCust.[t_applicationId],
    FCust.[t_extractionDtm]
FROM 
    intm_axbi.vw_FACT_CUSTPACKINGSLIPTRANS  FCust
    LEFT JOIN
        [map_AXBI].[SalesOrganization] AS SO
        ON
            FCust.[DATAAREAID] = SO.[source_DataAreaID] 
    LEFT JOIN
        [map_AXBI].[Material] as mapMaterial
        ON
            -- FCust.[DATAAREAID] = upper(SINMT.[AXDataAreaId])  
            -- AND
            FCust.[ITEMID] = mapMaterial.[source_Material]  
    LEFT JOIN
        [base_dw_halfen_0_hlp].[SAPCustomerBasicMappingTable] as SCMT
        ON
            FCust.[DATAAREAID] = upper(SCMT.[AXDataAreaId]) 
            AND
            FCust.[ORDERACCOUNT] = SCMT.[AXCustomeraccount]
    LEFT JOIN
        [edw].[dim_Customer] DimCust
        ON
            DimCust.[CustomerExternalID] = SCMT.[SAPCustomeraccount]

    LEFT JOIN intm_axbi.vw_FACT_SALESLINE FSL
        ON 
            FSL.[INVENTTRANSID] = FCust.[INVENTTRANSID]  
            AND 
            FSL.[DATAAREAID] = FCust.[DATAAREAID]
