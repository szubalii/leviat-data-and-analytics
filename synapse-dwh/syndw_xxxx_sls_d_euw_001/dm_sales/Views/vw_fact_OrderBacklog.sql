CREATE VIEW [dm_sales].[vw_fact_OrderBacklog]
AS
WITH doc_cnt AS(
    SELECT 
        doc.SalesDocument
    , doc.SalesDocumentItem
    , count(*) as CountScheduleLines

    FROM [base_s4h_cax].[C_SalesDocumentItemDEX] doc

    LEFT  JOIN base_s4h_cax.I_SalesDocumentScheduleLine SDSL 
        ON doc.SalesDocument = SDSL.SalesDocument 
            AND doc.SalesDocumentItem = SDSL.SalesDocumentItem

    GROUP BY doc.SalesDocument, doc.SalesDocumentItem
),

doc_delivery AS(
    SELECT 
        SalesDocument
        , SalesDocumentItem
        , MIN(ScheduleLine) as MinScheduleLine
        , RequestedDeliveryDate

    FROM base_s4h_cax.I_SalesDocumentScheduleLine

    WHERE IsRequestedDelivSchedLine = 'X'

    GROUP BY SalesDocument, SalesDocumentItem, RequestedDeliveryDate
)

SELECT 
      doc.SalesDocument
    , doc.SalesDocumentItem
    , doc.SDDocumentCategory as SDDocumentCategoryID
    , SDCT.SDDocumentCategoryName as SDDocumentCategory
    , doc.SalesOrganization as SalesOrganizationID
    , SORG.SalesOrganizationName as SalesOrganization
    , doc.Plant as PlantID
    , PLNT.PlantName as Plant
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
    , SDICT.SalesDocumentItemCategoryName as SalesDocumentItemCategory
    , doc.SoldToParty as SoldToPartyID
    , CSTMR.Country as CountryID
    , doc.SDDocumentRejectionStatus as SDDocumentRejectionStatusID
    , OBD.DeliveryDate
    , OBD.LoadingDate
    , SDSL.ScheduleLine
    , SDSL.ConfdOrderQtyByMatlAvailCheck
    , OBDI.OutboundDelivery
    , OBDI.OutboundDeliveryItem
    , OBDI.Plant as OBD_Plant 
    , OBD.PlannedGoodsIssueDate
    , OBD.ActualGoodsMovementDate
    , OBD.ShippingPoint
    , OBDI.ReferenceSDDocument
    , OBDI.ReferenceSDDocumentItem 
    , OBD.OverallGoodsMovementStatus
    , OBD.DeliveryPriority
    , doc.t_extractionDtm
    , doc_cnt.CountScheduleLines
    , SDRS.SDDocumentRejectionStatus
    , GMS.OverallGoodsMovementStatusDesc
    , CT.CountryName
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
    , SDSL.SchLineConfirmedDeliveryDate
    , doc_delivery.RequestedDeliveryDate as RequestedDeliveryDate_Added
    , OBDI.ActualDeliveryQuantity
    , CASE
        WHEN IL.SDDocument IS NULL
            THEN 'No'
        ELSE 'Yes'
      END                               AS IsIncomplete

FROM [base_s4h_cax].[C_SalesDocumentItemDEX] doc

LEFT  JOIN base_s4h_cax.I_SalesOrganizationText SORG
    ON doc.SalesOrganization = SORG.SalesOrganization
        AND SORG.Language = 'E'

LEFT  JOIN base_s4h_cax.I_Plant PLNT
    ON doc.Plant = PLNT.Plant

LEFT  JOIN base_s4h_cax.I_SalesDocumentItemCategoryT SDICT
    ON doc.SalesDocumentItemCategory = SDICT.SalesDocumentItemCategory
        AND SDICT.Language = 'E'

LEFT  JOIN base_s4h_cax.I_Customer CSTMR  
    ON doc.SoldToParty = CSTMR.Customer

LEFT  JOIN base_s4h_cax.I_OutboundDeliveryItem OBDI
    ON doc.SalesDocument = OBDI.ReferenceSDDocument
        AND doc.SalesDocumentItem = OBDI.ReferenceSDDocumentItem

LEFT  JOIN base_s4h_cax.I_OutboundDelivery OBD 
    ON OBDI.OutboundDelivery = OBD.OutboundDelivery

LEFT  JOIN base_s4h_cax.I_SalesDocumentScheduleLine SDSL 
    ON doc.SalesDocument = SDSL.SalesDocument 
        AND doc.SalesDocumentItem = SDSL.SalesDocumentItem

LEFT  JOIN base_s4h_cax.I_SDDocumentCategoryText SDCT
    ON doc.SDDocumentCategory = SDCT.SDDocumentCategory
        AND SDCT.Language = 'E'

LEFT  JOIN doc_cnt 
    ON doc.SalesDocument = doc_cnt.SalesDocument
        AND doc.SalesDocumentItem = doc_cnt.SalesDocumentItem

LEFT  JOIN [edw].[dim_SDDocumentRejectionStatus] SDRS
    ON doc.SDDocumentRejectionStatus = SDRS.SDDocumentRejectionStatusID

LEFT  JOIN [base_s4h_cax].[I_OverallGoodsMovementStatusT] GMS
    ON OBD.OverallGoodsMovementStatus = GMS.OverallGoodsMovementStatus
        AND GMS.Language = 'E'

LEFT  JOIN base_s4h_cax.I_CountryText CT
    ON CSTMR.Country = CT.Country
        AND CT.Language = 'E'

LEFT JOIN [edw].[dim_SalesDocumentRjcnReason] as RejReas 
    ON doc.[SalesDocumentRjcnReason] = RejReas.[SalesDocumentRjcnReasonID]

LEFT JOIN doc_delivery
    ON doc.SalesDocument = doc_delivery.SalesDocument
        AND doc.SalesDocumentItem = doc_delivery.SalesDocumentItem 
        AND SDSL.IsConfirmedDelivSchedLine = 'X'

LEFT JOIN [edw].[dim_SDDocumentIncompletionLog] IL
    ON doc.SalesDocument = IL.SDDocument
        AND doc.SalesDocumentItem = IL.SDDocumentItem

WHERE doc.SDDocumentCategory = 'C'