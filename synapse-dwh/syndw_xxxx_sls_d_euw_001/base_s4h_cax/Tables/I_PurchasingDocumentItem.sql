CREATE TABLE [base_s4h_cax].[I_PurchasingDocumentItem]
-- Purchasing Document Item
(
    [MANDT]                          nchar(3) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingDocument]             nvarchar(10) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingDocumentItem]         char(5) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingDocumentItemUniqueID] nvarchar(15), -- collate Latin1_General_100_BIN2,
    [PurchasingDocumentCategory]     nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurchasingDocumentDeletionCode] nvarchar(1), -- collate Latin1_General_100_BIN2,
    [Material]                       nvarchar(40), -- collate Latin1_General_100_BIN2,
    [SupplierMaterialNumber]         nvarchar(35), -- collate Latin1_General_100_BIN2,
    [ManufacturerMaterial]           nvarchar(40), -- collate Latin1_General_100_BIN2,
    [ManufacturerPartNmbr]           nvarchar(40), -- collate Latin1_General_100_BIN2,
    [Manufacturer]                   nvarchar(10), -- collate Latin1_General_100_BIN2,
    [PurchasingDocumentItemText]     nvarchar(40), -- collate Latin1_General_100_BIN2,
    [CompanyCode]                    nvarchar(4), -- collate Latin1_General_100_BIN2,
    [Plant]                          nvarchar(4), -- collate Latin1_General_100_BIN2,
    [ManualDeliveryAddressID]        nvarchar(10), -- collate Latin1_General_100_BIN2,
    [ReferenceDeliveryAddressID]     nvarchar(10), -- collate Latin1_General_100_BIN2,
    [Customer]                       nvarchar(10), -- collate Latin1_General_100_BIN2,
    [Subcontractor]                  nvarchar(10), -- collate Latin1_General_100_BIN2,
    [SupplierIsSubcontractor]        nvarchar(1), -- collate Latin1_General_100_BIN2,
    [CrossPlantConfigurableProduct]  nvarchar(40), -- collate Latin1_General_100_BIN2,
    [ArticleCategory]                nvarchar(2), -- collate Latin1_General_100_BIN2,
    [PlndOrderReplnmtElmntType]      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [ProductPurchasePointsQtyUnit]   nvarchar(3), -- collate Latin1_General_100_BIN2,
    [ProductPurchasePointsQty]       decimal(13, 3),
    [StorageLocation]                nvarchar(4), -- collate Latin1_General_100_BIN2,
    [MaterialGroup]                  nvarchar(9), -- collate Latin1_General_100_BIN2,
    [OrderQuantityUnit]              nvarchar(3), -- collate Latin1_General_100_BIN2,
    [OrderItemQtyToBaseQtyNmrtr]     decimal(5),
    [OrderItemQtyToBaseQtyDnmntr]    decimal(5),
    [NetPriceQuantity]               decimal(5),
    [IsCompletelyDelivered]          nvarchar(1), -- collate Latin1_General_100_BIN2,
    [IsFinallyInvoiced]              nvarchar(1), -- collate Latin1_General_100_BIN2,
    [GoodsReceiptIsExpected]         nvarchar(1), -- collate Latin1_General_100_BIN2,
    [InvoiceIsExpected]              nvarchar(1), -- collate Latin1_General_100_BIN2,
    [InvoiceIsGoodsReceiptBased]     nvarchar(1), -- collate Latin1_General_100_BIN2,
    [GoodsReceiptIsNonValuated]      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurchaseRequisition]            nvarchar(10), -- collate Latin1_General_100_BIN2,
    [PurchaseRequisitionItem]        char(5), -- collate Latin1_General_100_BIN2,
    [ServicePackage]                 char(10), -- collate Latin1_General_100_BIN2,
    [ServicePerformer]               nvarchar(10), -- collate Latin1_General_100_BIN2,
    [ProductType]                    nvarchar(2), -- collate Latin1_General_100_BIN2,
    [MaterialType]                   nvarchar(4), -- collate Latin1_General_100_BIN2,
    [PurchaseContractItem]           char(5), -- collate Latin1_General_100_BIN2,
    [PurchaseContract]               nvarchar(10), -- collate Latin1_General_100_BIN2,
    [RequestForQuotation]            nvarchar(10), -- collate Latin1_General_100_BIN2,
    [RequestForQuotationItem]        char(5), -- collate Latin1_General_100_BIN2,
    [EvaldRcptSettlmtIsAllowed]      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [UnlimitedOverdeliveryIsAllowed] nvarchar(1), -- collate Latin1_General_100_BIN2,
    [OverdelivTolrtdLmtRatioInPct]   decimal(3, 1),
    [UnderdelivTolrtdLmtRatioInPct]  decimal(3, 1),
    [RequisitionerName]              nvarchar(12), -- collate Latin1_General_100_BIN2,
    [MRPArea]                        nvarchar(10), -- collate Latin1_General_100_BIN2,
    [IncotermsClassification]        nvarchar(3), -- collate Latin1_General_100_BIN2,
    [IncotermsTransferLocation]      nvarchar(28), -- collate Latin1_General_100_BIN2,
    [IncotermsLocation1]             nvarchar(70), -- collate Latin1_General_100_BIN2,
    [IncotermsLocation2]             nvarchar(70), -- collate Latin1_General_100_BIN2,
    [PriorSupplier]                  nvarchar(10), -- collate Latin1_General_100_BIN2,
    [InternationalArticleNumber]     nvarchar(18), -- collate Latin1_General_100_BIN2,
    [SupplierConfirmationControlKey] nvarchar(4), -- collate Latin1_General_100_BIN2,
    [PriceIsToBePrinted]             nvarchar(1), -- collate Latin1_General_100_BIN2,
    [BaseUnit]                       nvarchar(3), -- collate Latin1_General_100_BIN2,
    [PurchasingDocumentItemCategory] nvarchar(1), -- collate Latin1_General_100_BIN2,
    [ProfitCenter]                   nvarchar(10), -- collate Latin1_General_100_BIN2,
    [OrderPriceUnit]                 nvarchar(3), -- collate Latin1_General_100_BIN2,
    [VolumeUnit]                     nvarchar(3), -- collate Latin1_General_100_BIN2,
    [WeightUnit]                     nvarchar(3), -- collate Latin1_General_100_BIN2,
    [MultipleAcctAssgmtDistribution] nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PartialInvoiceDistribution]     nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PricingDateControl]             nvarchar(1), -- collate Latin1_General_100_BIN2,
    [IsStatisticalItem]              nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurchasingParentItem]           char(5), -- collate Latin1_General_100_BIN2,
    [GoodsReceiptLatestCreationDate] date,
    [IsReturnsItem]                  nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurchasingOrderReason]          nvarchar(3), -- collate Latin1_General_100_BIN2,
    [AccountAssignmentCategory]      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurchasingInfoRecord]           nvarchar(10), -- collate Latin1_General_100_BIN2,
    [NetAmount]                      decimal(13, 2),
    [GrossAmount]                    decimal(13, 2),
    [EffectiveAmount]                decimal(13, 2),
    [Subtotal1Amount]                decimal(13, 2),
    [Subtotal2Amount]                decimal(13, 2),
    [Subtotal3Amount]                decimal(13, 2),
    [Subtotal4Amount]                decimal(13, 2),
    [Subtotal5Amount]                decimal(13, 2),
    [Subtotal6Amount]                decimal(13, 2),
    [TargetQuantity]                 decimal(13, 3),
    [OrderQuantity]                  decimal(13, 3),
    [NetPriceAmount]                 decimal(11, 2),
    [TargetAmount]                   decimal(13, 2),
    [ItemVolume]                     decimal(13, 3),
    [ItemGrossWeight]                decimal(13, 3),
    [ItemNetWeight]                  decimal(13, 3),
    [OrderPriceUnitToOrderUnitNmrtr] decimal(5),
    [OrdPriceUnitToOrderUnitDnmntr]  decimal(5),
    [SchedAgrmtCumQtyReconcileDate]  date,
    [SchedAgrmtAgreedCumQty]         decimal(13, 3),
    [ItemLastTransmissionDate]       date,
    [ScheduleLineFirmOrderInDays]    decimal(3),
    [SchedLineSemiFirmOrderInDays]   decimal(3),
    [NoDaysReminder1]                decimal(3),
    [NoDaysReminder2]                decimal(3),
    [NoDaysReminder3]                decimal(3),
    [RequirementTracking]            nvarchar(10), -- collate Latin1_General_100_BIN2,
    [IsOrderAcknRqd]                 nvarchar(1), -- collate Latin1_General_100_BIN2,
    [StockType]                      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [TaxCode]                        nvarchar(2), -- collate Latin1_General_100_BIN2,
    [TaxJurisdiction]                nvarchar(15), -- collate Latin1_General_100_BIN2,
    [ShippingInstruction]            nvarchar(2), -- collate Latin1_General_100_BIN2,
    [NonDeductibleInputTaxAmount]    decimal(13, 2),
    [ValuationType]                  nvarchar(10), -- collate Latin1_General_100_BIN2,
    [ValuationCategory]              nvarchar(1), -- collate Latin1_General_100_BIN2,
    [ItemIsRejectedBySupplier]       nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurgDocPriceDate]               date,
    [IsInfoRecordUpdated]            nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurgDocReleaseOrderQuantity]    decimal(13, 3),
    [PurgDocOrderAcknNumber]         nvarchar(20), -- collate Latin1_General_100_BIN2,
    [PurgDocEstimatedPrice]          nvarchar(1), -- collate Latin1_General_100_BIN2,
    [IsInfoAtRegistration]           nvarchar(1), -- collate Latin1_General_100_BIN2,
    [SupplierSubrange]               nvarchar(6), -- collate Latin1_General_100_BIN2,
    [CostCenter]                     nvarchar(10), -- collate Latin1_General_100_BIN2,
    [GLAccount]                      nvarchar(10), -- collate Latin1_General_100_BIN2,
    [WBSElementInternalID]           char(8), -- collate Latin1_General_100_BIN2,
    [Fund]                           nvarchar(10), -- collate Latin1_General_100_BIN2,
    [BudgetPeriod]                   nvarchar(10), -- collate Latin1_General_100_BIN2,
    [FundsCenter]                    nvarchar(16), -- collate Latin1_General_100_BIN2,
    [CommitmentItem]                 nvarchar(14), -- collate Latin1_General_100_BIN2,
    [FunctionalArea]                 nvarchar(16), -- collate Latin1_General_100_BIN2,
    [GrantID]                        nvarchar(20), -- collate Latin1_General_100_BIN2,
    [EarmarkedFunds]                 nvarchar(10), -- collate Latin1_General_100_BIN2,
    [EarmarkedFundsDocument]         nvarchar(10), -- collate Latin1_General_100_BIN2,
    [EarmarkedFundsItem]             char(3), -- collate Latin1_General_100_BIN2,
    [EarmarkedFundsDocumentItem]     char(3), -- collate Latin1_General_100_BIN2,
    [PlannedDeliveryDurationInDays]  decimal(3),
    [GoodsReceiptDurationInDays]     decimal(3),
    [PartialDeliveryIsAllowed]       nvarchar(1), -- collate Latin1_General_100_BIN2,
    [ConsumptionPosting]             nvarchar(1), -- collate Latin1_General_100_BIN2,
    [SchedgAgrmtRelCreationProfile]  nvarchar(4), -- collate Latin1_General_100_BIN2,
    [SchedAgrmtCumulativeQtyControl] nvarchar(1), -- collate Latin1_General_100_BIN2,
    [CumulativeQuantityIsNotSent]    nvarchar(1), -- collate Latin1_General_100_BIN2,
    [MinRemainingShelfLife]          decimal(4),
    [ShelfLifeExpirationDatePeriod]  nvarchar(1), -- collate Latin1_General_100_BIN2,
    [QualityMgmtCtrlKey]             nvarchar(8), -- collate Latin1_General_100_BIN2,
    [InventorySpecialStockType]      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [IsRelevantForJITDelivSchedule]  nvarchar(1), -- collate Latin1_General_100_BIN2,
    [NextJITDelivSchedSendingDate]   date,
    [NextFcstDelivSchedSendingDate]  date,
    [FirmTradeOffZoneBindMRP]        nvarchar(1), -- collate Latin1_General_100_BIN2,
    [QualityCertificateType]         nvarchar(4), -- collate Latin1_General_100_BIN2,
    [SupplierQuotation]              nvarchar(10), -- collate Latin1_General_100_BIN2,
    [SupplierQuotationItem]          char(5), -- collate Latin1_General_100_BIN2,
    [IntrastatServiceCode]           nvarchar(30), -- collate Latin1_General_100_BIN2,
    [CommodityCode]                  nvarchar(30), -- collate Latin1_General_100_BIN2,
    [DeliveryDocumentType]           nvarchar(4), -- collate Latin1_General_100_BIN2,
    [MaterialFreightGroup]           nvarchar(8), -- collate Latin1_General_100_BIN2,
    [DiscountInKindEligibility]      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurgItemIsBlockedForDelivery]   nvarchar(1), -- collate Latin1_General_100_BIN2,
    [IssuingStorageLocation]         nvarchar(4), -- collate Latin1_General_100_BIN2,
    [AllocationTable]                nvarchar(10), -- collate Latin1_General_100_BIN2,
    [AllocationTableItem]            char(5), -- collate Latin1_General_100_BIN2,
    [RetailPromotion]                nvarchar(10), -- collate Latin1_General_100_BIN2,
    [DownPaymentType]                nvarchar(4), -- collate Latin1_General_100_BIN2,
    [DownPaymentPercentageOfTotAmt]  decimal(5, 2),
    [DownPaymentAmount]              decimal(11, 2),
    [DownPaymentDueDate]             date,
    [ExpectedOverallLimitAmount]     decimal(13, 2),
    [OverallLimitAmount]             decimal(13, 2),
    [RequirementSegment]             nvarchar(40), -- collate Latin1_General_100_BIN2,
    [BR_MaterialOrigin]              nvarchar(1), -- collate Latin1_General_100_BIN2,
    [BR_MaterialUsage]               nvarchar(1), -- collate Latin1_General_100_BIN2,
    [BR_CFOPCategory]                nvarchar(2), -- collate Latin1_General_100_BIN2,
    [BR_NCM]                         nvarchar(16), -- collate Latin1_General_100_BIN2,
    [ConsumptionTaxCtrlCode]         nvarchar(16), -- collate Latin1_General_100_BIN2,
    [BR_IsProducedInHouse]           nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurchasingCentralMaterial]      nvarchar(40), -- collate Latin1_General_100_BIN2,
    [PurgDocItmTargetAmount]         decimal(15, 2),
    [IsEndOfPurposeBlocked]          nvarchar(1), -- collate Latin1_General_100_BIN2,
    [DocumentCurrency]               nchar(5), -- collate Latin1_General_100_BIN2,
    [StockSegment]                   nvarchar(40), -- collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR(32),
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_jobBy]                        NVARCHAR(128),
    [t_extractionDtm]                DATETIME,
    [t_filePath]                     NVARCHAR(1024),
    CONSTRAINT [PK_I_PurchasingDocumentItem] PRIMARY KEY NONCLUSTERED ([MANDT], [PurchasingDocument], [PurchasingDocumentItem]) NOT ENFORCED
)
WITH (HEAP)
