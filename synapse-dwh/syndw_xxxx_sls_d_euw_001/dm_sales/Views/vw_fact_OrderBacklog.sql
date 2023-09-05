CREATE VIEW [dm_sales].[vw_fact_OrderBacklog]
AS
WITH doc_cnt AS(
    SELECT 
        doc.SalesDocument
    , doc.SalesDocumentItem
    , count(*) as CountScheduleLines

    FROM [base_s4h_cax].[C_SalesDocumentItemDEX] doc

    LEFT  JOIN [edw].[dim_SalesDocumentScheduleLine] SDSL 
        ON doc.SalesDocument = SDSL.SalesDocumentID
            AND doc.SalesDocumentItem = SDSL.SalesDocumentItem

    GROUP BY doc.SalesDocument, doc.SalesDocumentItem
),

doc_delivery AS(
    SELECT 
        SalesDocumentID
        , SalesDocumentItem
        , MIN(ScheduleLine) as MinScheduleLine
        , RequestedDeliveryDate

    FROM [edw].[dim_SalesDocumentScheduleLine]

    WHERE IsRequestedDelivSchedLine = 'X'

    GROUP BY SalesDocumentID, SalesDocumentItem, RequestedDeliveryDate
),

CTE_IncompletionLog AS (
    SELECT
        SDDocument,
        SDDocumentItem
    FROM
        [edw].[dim_SDDocumentIncompletionLog]
    GROUP BY
        SDDocument,
        SDDocumentItem
)

SELECT 
      doc.SalesDocument
    , doc.SalesDocumentItem
    , edw.svf_get2PartNaturalKey(doc.SalesDocument, doc.SalesDocumentItem)  AS nk_SDDocumentItem
    , doc.SDDocumentCategory as SDDocumentCategoryID
    , SDCT.SDDocumentCategory
    , doc.SalesOrganization as SalesOrganizationID
    , SORG.SalesOrganization
    , doc.Plant as PlantID
    , PLNT.Plant
    , doc.SalesGroup as SalesGroupID 
    , doc.SalesOffice as SalesOfficeID
    , doc.Material
    , doc.[SalesDocumentType]
    , CASE 
        WHEN YEAR(SDSL.[ConfirmedDeliveryDate]) = 1899 
            THEN NULL
        ELSE SDSL.[ConfirmedDeliveryDate]
      END AS [ConfirmedDeliveryDate]
    , doc.OrderQuantity
    , doc.OrderQuantityUnit
    , doc.ItemGrossWeight as SDOC_ItemGrossWeight
    , doc.ItemNetWeight as SDOC_ItemNetWeight
    , doc.ItemWeightUnit as SDOC_ItemWeightUnit
    , doc.DeliveryPriority as SDOC_DeliveryPriority
    , OBDI.ItemGrossWeight as BDI_ItemGrossWeight
    , OBDI.ItemNetWeight as BDI_ItemNetWeight
    , OBDI.ItemWeightUnit as BDI_ItemWeightUnit 
    , doc.NetAmount
    , doc.Currency
    , doc.CreationDate
    , doc.RequestedDeliveryDate
    , doc.SalesDocumentItemCategory as SalesDocumentItemCategoryID
    , SDICT.SalesDocumentItemCategoryName   AS SalesDocumentItemCategory
    , doc.SoldToParty as SoldToPartyID
    , CSTMR.CountryID
    , doc.SDDocumentRejectionStatus as SDDocumentRejectionStatusID
    , OBDI.HDR_DeliveryDate         AS DeliveryDate
    , OBDI.HDR_LoadingDate          AS LoadingDate
    , SDSL.ScheduleLine
    , SDSL.ConfdOrderQtyByMatlAvailCheck
    , OBDI.OutboundDelivery
    , OBDI.OutboundDeliveryItem
    , OBDI.PlantID as OBD_Plant 
    , OBDI.HDR_PlannedGoodsIssueDate    AS PlannedGoodsIssueDate
    , OBDI.HDR_ActualGoodsMovementDate  AS ActualGoodsMovementDate
    , OBDI.HDR_ShippingPointID          AS ShippingPoint
    , OBDI.ReferenceSDDocument
    , OBDI.ReferenceSDDocumentItem 
    , OBDI.HDR_OverallGoodsMovementStatusID AS OverallGoodsMovementStatus
    , OBDI.HDR_DeliveryPriority         AS DeliveryPriority
    , doc.t_extractionDtm
    , doc_cnt.CountScheduleLines
    , SDRS.SDDocumentRejectionStatus
    , GMS.OverallGoodsMovementStatusDesc
    , CT.Country                        AS CountryName
    , doc.[SalesDocumentRjcnReason] as RejectionReasonID
    , RejReas.[SalesDocumentRjcnReason] as RejectionReason
    , SDSL.[DeliveryDate] AS SDLS_DeliveryDate
    , SDSL.[RequestedDeliveryDate] AS SDLS_RequestedDeliveryDate
    , SDSL.[DeliveryCreationDate] AS SDSL_DeliveryCreationDate
    , SDSL.[ConfdSchedLineReqdDelivDate] AS SDSL_ConfirmedReqDeliveryDate
    , SDSL.[ProductAvailabilityDate] as SDSL_ProductAvailabilityDate
    , SDSL.[GoodsIssueDate] as SDSL_GoodsIssueDate
    , MIN(SDSL.[DeliveryDate]) OVER (PARTITION BY doc.SalesDocumentItem) AS SDI_1stSDLSDeliveryDate
    , doc.DeliveryBlockReason
    , SDSL.DelivBlockReasonForSchedLine
    , SDSL.IsConfirmedDelivSchedLine
    , SDSL.IsRequestedDelivSchedLine
    , SDSL.ConfirmedDeliveryDate                                        AS SchLineConfirmedDeliveryDate
    , doc_delivery.RequestedDeliveryDate                                AS RequestedDeliveryDate_Added
    , OBDI.ActualDeliveryQuantity
    , CASE
        WHEN IL.SDDocumentItem IS NULL 
            THEN 'No' 
        ELSE 'Yes'
      END                                                               AS IsIncomplete

FROM [base_s4h_cax].[C_SalesDocumentItemDEX] doc

LEFT  JOIN [edw].[dim_SalesOrganization] SORG
    ON doc.SalesOrganization = SORG.SalesOrganizationID

LEFT  JOIN [edw].[dim_Plant] PLNT
    ON doc.Plant = PLNT.PlantID

LEFT  JOIN base_s4h_cax.I_SalesDocumentItemCategoryT SDICT
    ON doc.SalesDocumentItemCategory = SDICT.SalesDocumentItemCategory
        AND SDICT.Language = 'E'

LEFT  JOIN [edw].[dim_Customer] CSTMR  
    ON doc.SoldToParty = CSTMR.CustomerID

LEFT  JOIN [edw].[fact_OutboundDeliveryItem] OBDI
    ON doc.SalesDocument = OBDI.ReferenceSDDocument
        AND doc.SalesDocumentItem = OBDI.ReferenceSDDocumentItem

LEFT  JOIN [edw].[dim_SalesDocumentScheduleLine] SDSL 
    ON doc.SalesDocument = SDSL.SalesDocumentID
        AND doc.SalesDocumentItem = SDSL.SalesDocumentItem

LEFT  JOIN [edw].[dim_SDDocumentCategory] SDCT
    ON doc.SDDocumentCategory = SDCT.SDDocumentCategoryID

LEFT  JOIN doc_cnt 
    ON doc.SalesDocument = doc_cnt.SalesDocument
        AND doc.SalesDocumentItem = doc_cnt.SalesDocumentItem

LEFT  JOIN [edw].[dim_SDDocumentRejectionStatus] SDRS
    ON doc.SDDocumentRejectionStatus = SDRS.SDDocumentRejectionStatusID

LEFT  JOIN [base_s4h_cax].[I_OverallGoodsMovementStatusT] GMS
    ON OBDI.HDR_OverallGoodsMovementStatusID = GMS.OverallGoodsMovementStatus
        AND GMS.Language = 'E'

LEFT  JOIN [edw].[dim_Country] CT
    ON CSTMR.CountryID = CT.CountryID

LEFT JOIN [edw].[dim_SalesDocumentRjcnReason] as RejReas 
    ON doc.[SalesDocumentRjcnReason] = RejReas.[SalesDocumentRjcnReasonID]

LEFT JOIN doc_delivery
    ON doc.SalesDocument = doc_delivery.SalesDocumentID
        AND doc.SalesDocumentItem = doc_delivery.SalesDocumentItem 
        AND SDSL.IsConfirmedDelivSchedLine = 'X'

LEFT JOIN CTE_IncompletionLog IL
    ON doc.SalesDocument = IL.SDDocument COLLATE DATABASE_DEFAULT
        AND doc.SalesDocumentItem = IL.SDDocumentItem COLLATE DATABASE_DEFAULT

WHERE doc.SDDocumentCategory = 'C'