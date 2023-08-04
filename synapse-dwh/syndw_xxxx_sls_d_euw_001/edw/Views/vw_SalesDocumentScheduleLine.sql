CREATE VIEW [edw].[vw_SalesDocumentScheduleLine]
	AS SELECT
        SalesDocumentScheduleLine.[SalesDocument] AS [SalesDocumentID]
        ,SalesDocumentScheduleLine.[SalesDocumentItem]
        ,SalesDocumentScheduleLine.[ScheduleLine]
        ,SalesDocumentScheduleLine.[ScheduleLineCategory]
        ,SalesDocumentScheduleLine.[OrderQuantityUnit]
        ,SalesDocumentScheduleLine.[IsRequestedDelivSchedLine]
        ,SalesDocumentScheduleLine.[RequestedDeliveryDate]
        ,SalesDocumentScheduleLine.[ScheduleLineOrderQuantity]
        ,SalesDocumentScheduleLine.[CorrectedQtyInOrderQtyUnit]
        ,SalesDocumentScheduleLine.[IsConfirmedDelivSchedLine]
        ,SalesDocumentScheduleLine.[ConfirmedDeliveryDate]
        ,SalesDocumentScheduleLine.[ConfdOrderQtyByMatlAvailCheck]
        ,SalesDocumentScheduleLine.[ConfdSchedLineReqdDelivDate]
        ,SalesDocumentScheduleLine.[ProductAvailabilityDate]
        ,SalesDocumentScheduleLine.[ScheduleLineConfirmationStatus]
        ,SalesDocumentScheduleLine.[PlannedOrder]
        ,SalesDocumentScheduleLine.[OrderID]
        ,SalesDocumentScheduleLine.[DeliveryCreationDate]
        ,SalesDocumentScheduleLine.[GoodsIssueDate]
        ,SalesDocumentScheduleLine.[LoadingDate]
        ,SalesDocumentScheduleLine.[ItemIsDeliveryRelevant]
        ,SalesDocumentScheduleLine.[DelivBlockReasonForSchedLine]
        ,SalesDocumentScheduleLine.[DeliveredQtyInOrderQtyUnit]
        ,SalesDocumentScheduleLine.[DeliveredQuantityInBaseUnit]
        ,SalesDocumentScheduleLine.[DeliveryDate]
        ,fact_SalesDocumentItem.[SalesOrganizationID]
        ,fact_SalesDocumentItem.[MaterialID]
        ,fact_SalesDocumentItem.[SoldToPartyID]
        ,fact_SalesDocumentItem.[SalesDocumentDate]
        ,SalesDocumentScheduleLine.[t_applicationId]
    FROM
        [base_s4h_cax].[I_SalesDocumentScheduleLine] SalesDocumentScheduleLine
    LEFT JOIN
        [edw].[fact_SalesDocumentItem] fact_SalesDocumentItem
    ON
        SalesDocumentScheduleLine.[SalesDocument] = fact_SalesDocumentItem.[SalesDocument]
        AND
		SalesDocumentScheduleLine.[SalesDocumentItem] = fact_SalesDocumentItem.[SalesDocumentItem]
        AND
		fact_SalesDocumentItem.[CurrencyTypeID] = 10
		-- AND
        -- SalesDocumentScheduleLine.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
