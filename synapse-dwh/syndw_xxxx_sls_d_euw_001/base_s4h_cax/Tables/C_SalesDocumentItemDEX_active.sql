CREATE TABLE [base_s4h_cax].[C_SalesDocumentItemDEX_active]
(
    [MANDT]                          char(3) collate Latin1_General_100_BIN2 NOT NULL,
    [SalesDocument]                  nvarchar(10)                            NOT NULL,
    [SalesDocumentItem]              char(6) collate Latin1_General_100_BIN2 NOT NULL,
    [SDDocumentCategory]             nvarchar(4),
    [SalesDocumentType]              nvarchar(4),
    [SalesDocumentItemCategory]      nvarchar(4),
    [IsReturnsItem]                  nvarchar(1),
    [CreationDate]                   date,
    [CreationTime]                   time(0),
    [LastChangeDate]                 date,
    [SalesOrganization]              nvarchar(4),
    [DistributionChannel]            nvarchar(2),
    [Division]                       nvarchar(2),
    [SalesGroup]                     nvarchar(3),
    [SalesOffice]                    nvarchar(4),
    [InternationalArticleNumber]     nvarchar(18),
    [Batch]                          nvarchar(10),
    [Material]                       nvarchar(40),
    [OriginallyRequestedMaterial]    nvarchar(40),
    [MaterialSubstitutionReason]     nvarchar(4),
    [MaterialGroup]                  nvarchar(9),
    [AdditionalMaterialGroup1]       nvarchar(3),
    [AdditionalMaterialGroup2]       nvarchar(3),
    [AdditionalMaterialGroup3]       nvarchar(3),
    [AdditionalMaterialGroup4]       nvarchar(3),
    [AdditionalMaterialGroup5]       nvarchar(3),
    [SoldToParty]                    nvarchar(10),
    [AdditionalCustomerGroup1]       nvarchar(3),
    [AdditionalCustomerGroup2]       nvarchar(3),
    [AdditionalCustomerGroup3]       nvarchar(3),
    [AdditionalCustomerGroup4]       nvarchar(3),
    [AdditionalCustomerGroup5]       nvarchar(3),
    [ShipToParty]                    nvarchar(10),
    [PayerParty]                     nvarchar(10),
    [BillToParty]                    nvarchar(10),
    [SDDocumentReason]               nvarchar(3),
    [SalesDocumentDate]              date,
    [OrderQuantity]                  decimal(15, 3),
    [OrderQuantityUnit]              nvarchar(3) collate Latin1_General_100_BIN2,
    [TargetQuantity]                 decimal(13, 3),
    [TargetQuantityUnit]             nvarchar(3) collate Latin1_General_100_BIN2,
    [TargetToBaseQuantityDnmntr]     decimal(5),
    [TargetToBaseQuantityNmrtr]      decimal(5),
    [OrderToBaseQuantityDnmntr]      decimal(5),
    [OrderToBaseQuantityNmrtr]       decimal(5),
    [ConfdDelivQtyInOrderQtyUnit]    decimal(15, 3),
    [TargetDelivQtyInOrderQtyUnit]   decimal(15, 3),
    [ConfdDeliveryQtyInBaseUnit]     decimal(15, 3),
    [BaseUnit]                       nvarchar(3) collate Latin1_General_100_BIN2,
    [ItemGrossWeight]                decimal(15, 3),
    [ItemNetWeight]                  decimal(15, 3),
    [ItemWeightUnit]                 nvarchar(3) collate Latin1_General_100_BIN2,
    [ItemVolume]                     decimal(15, 3),
    [ItemVolumeUnit]                 nvarchar(3) collate Latin1_General_100_BIN2,
    [ServicesRenderedDate]           date,
    [SalesDistrict]                  nvarchar(6),
    [CustomerGroup]                  nvarchar(2),
    [HdrOrderProbabilityInPercent]   char(3) collate Latin1_General_100_BIN2,
    [ItemOrderProbabilityInPercent]  char(3) collate Latin1_General_100_BIN2,
    [SalesDocumentRjcnReason]        nvarchar(2),
    [PricingDate]                    date,
    [ExchangeRateDate]               date,
    [PriceDetnExchangeRate]          decimal(9, 5),
    [StatisticalValueControl]        nvarchar(1),
    [NetAmount]                      decimal(15, 2),
    [TransactionCurrency]            char(5) collate Latin1_General_100_BIN2,
    [SalesOrganizationCurrency]      char(5) collate Latin1_General_100_BIN2,
    [NetPriceAmount]                 decimal(11, 2),
    [NetPriceQuantity]               decimal(5),
    [NetPriceQuantityUnit]           nvarchar(3) collate Latin1_General_100_BIN2,
    [TaxAmount]                      decimal(13, 2),
    [CostAmount]                     decimal(13, 2),
    [Subtotal1Amount]                decimal(13, 2),
    [Subtotal2Amount]                decimal(13, 2),
    [Subtotal3Amount]                decimal(13, 2),
    [Subtotal4Amount]                decimal(13, 2),
    [Subtotal5Amount]                decimal(13, 2),
    [Subtotal6Amount]                decimal(13, 2),
    [ShippingPoint]                  nvarchar(4),
    [ShippingType]                   nvarchar(2),
    [DeliveryPriority]               char(2) collate Latin1_General_100_BIN2,
    [InventorySpecialStockType]      nvarchar(1),
    [RequestedDeliveryDate]          date,
    [ShippingCondition]              nvarchar(2),
    [DeliveryBlockReason]            nvarchar(2),
    [Plant]                          nvarchar(4),
    [StorageLocation]                nvarchar(4),
    [Route]                          nvarchar(6),
    [IncotermsClassification]        nvarchar(3),
    [IncotermsVersion]               nvarchar(4),
    [IncotermsTransferLocation]      nvarchar(28),
    [IncotermsLocation1]             nvarchar(70),
    [IncotermsLocation2]             nvarchar(70),
    [MinDeliveryQtyInBaseUnit]       decimal(13, 3),
    [UnlimitedOverdeliveryIsAllowed] nvarchar(1),
    [OverdelivTolrtdLmtRatioInPct]   decimal(3, 1),
    [UnderdelivTolrtdLmtRatioInPct]  decimal(3, 1),
    [PartialDeliveryIsAllowed]       nvarchar(1),
    [BindingPeriodValidityStartDate] date,
    [BindingPeriodValidityEndDate]   date,
    [OutlineAgreementTargetAmount]   decimal(13, 2),
    [BillingDocumentDate]            date,
    [BillingCompanyCode]             nvarchar(4),
    [HeaderBillingBlockReason]       nvarchar(2),
    [ItemBillingBlockReason]         nvarchar(2),
    [FiscalYear]                     char(4) collate Latin1_General_100_BIN2,
    [FiscalPeriod]                   char(3) collate Latin1_General_100_BIN2,
    [CustomerAccountAssignmentGroup] nvarchar(2),
    [ExchangeRateType]               nvarchar(4),
    [Currency]                       char(5) collate Latin1_General_100_BIN2,
    [FiscalYearVariant]              nvarchar(2),
    [BusinessArea]                   nvarchar(4),
    [ProfitCenter]                   nvarchar(10),
    [OrderID]                        nvarchar(12),
    [ProfitabilitySegment]           char(10) collate Latin1_General_100_BIN2,
    [ControllingArea]                nvarchar(4),
    [ReferenceSDDocument]            nvarchar(10),
    [ReferenceSDDocumentItem]        char(6) collate Latin1_General_100_BIN2,
    [ReferenceSDDocumentCategory]    nvarchar(4),
    [OriginSDDocument]               nvarchar(10),
    [OriginSDDocumentItem]           char(6) collate Latin1_General_100_BIN2,
    [OverallSDProcessStatus]         nvarchar(1),
    [OverallTotalDeliveryStatus]     nvarchar(1),
    [OverallOrdReltdBillgStatus]     nvarchar(1),
    [TotalCreditCheckStatus]         nvarchar(1),
    [DeliveryBlockStatus]            nvarchar(1),
    [BillingBlockStatus]             nvarchar(1),
    [TotalSDDocReferenceStatus]      nvarchar(1),
    [SDDocReferenceStatus]           nvarchar(1),
    [OverallSDDocumentRejectionSts]  nvarchar(1),
    [SDDocumentRejectionStatus]      nvarchar(1),
    [OverallTotalSDDocRefStatus]     nvarchar(1),
    [OverallSDDocReferenceStatus]    nvarchar(1),
    [ItemGeneralIncompletionStatus]  nvarchar(1),
    [ItemBillingIncompletionStatus]  nvarchar(1),
    [PricingIncompletionStatus]      nvarchar(1),
    [ItemDeliveryIncompletionStatus] nvarchar(1),
    [SDoc_ControllingObject]         nvarchar(22) collate Latin1_General_100_BIN2,
    [SDItem_ControllingObject]       nvarchar(22) collate Latin1_General_100_BIN2,
    [CorrespncExternalReference]     char(12),
    [t_applicationId]                VARCHAR(32),
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_jobBy]                        NVARCHAR(128),
    [t_extractionDtm]                DATETIME,
    [t_lastActionBy]                 VARCHAR(128),
    [t_lastActionCd]                 CHAR(1),
    [t_lastActionDtm]                DATETIME,
    [t_filePath]                     NVARCHAR(1024),
    CONSTRAINT [PK_C_SalesDocumentItemDEX_active] PRIMARY KEY NONCLUSTERED (
        [MANDT], [SalesDocument],
        [SalesDocumentItem]
    ) NOT ENFORCED
)
    WITH ( DISTRIBUTION = HASH (SalesDocument), CLUSTERED COLUMNSTORE INDEX )
