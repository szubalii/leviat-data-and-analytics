CREATE TABLE [base_s4h_cax].[C_BillingDocumentItemBasicDEX]
(
    [MANDT]                          char(3) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [BillingDocument]                nvarchar(10)                            NOT NULL,
    [BillingDocumentItem]            char(6) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [SalesDocumentItemCategory]      nvarchar(4),
    [SalesDocumentItemType]          nvarchar(1),
    [ReturnItemProcessingType]       nvarchar(1),
    [BillingDocumentType]            nvarchar(4),
    [BillingDocumentCategory]        nvarchar(1),
    [SDDocumentCategory]             nvarchar(4),
    [CreationDate]                   date,
    [CreationTime]                   time(0),
    [LastChangeDate]                 date,
    [BillingDocumentDate]            date,
    [BillingDocumentIsTemporary]     nvarchar(1),
    [OrganizationDivision]           nvarchar(2),
    [Division]                       nvarchar(2),
    [SalesOffice]                    nvarchar(4),
    [SalesOrganization]              nvarchar(4),
    [DistributionChannel]            nvarchar(2),
    [Material]                       nvarchar(40),
    [OriginallyRequestedMaterial]    nvarchar(40),
    [InternationalArticleNumber]     nvarchar(18),
    [PricingReferenceMaterial]       nvarchar(40),
    [Batch]                          nvarchar(10),
    [MaterialGroup]                  nvarchar(9),
    [AdditionalMaterialGroup1]       nvarchar(3),
    [AdditionalMaterialGroup2]       nvarchar(3),
    [AdditionalMaterialGroup3]       nvarchar(3),
    [AdditionalMaterialGroup4]       nvarchar(3),
    [AdditionalMaterialGroup5]       nvarchar(3),
    [MaterialCommissionGroup]        nvarchar(2),
    [Plant]                          nvarchar(4),
    [StorageLocation]                nvarchar(4),
    [BillingDocumentIsCancelled]     nvarchar(1),
    [CancelledBillingDocument]       nvarchar(10),
    [BillingDocumentItemText]        nvarchar(40),
    [ServicesRenderedDate]           date,
    [BillingQuantity]                decimal(13, 3),
    [BillingQuantityUnit]            nvarchar(3), -- collate Latin1_General_100_BIN2,
    [BillingQuantityInBaseUnit]      decimal(13, 3),
    [BaseUnit]                       nvarchar(3), -- collate Latin1_General_100_BIN2,
    [MRPRequiredQuantityInBaseUnit]  decimal(13, 3),
    [BillingToBaseQuantityDnmntr]    decimal(5),
    [BillingToBaseQuantityNmrtr]     decimal(5),
    [ItemGrossWeight]                decimal(15, 3),
    [ItemNetWeight]                  decimal(15, 3),
    [ItemWeightUnit]                 nvarchar(3), -- collate Latin1_General_100_BIN2,
    [ItemVolume]                     decimal(15, 3),
    [ItemVolumeUnit]                 nvarchar(3), -- collate Latin1_General_100_BIN2,
    [BillToPartyCountry]             nvarchar(3),
    [BillToPartyRegion]              nvarchar(3),
    [BillingPlanRule]                nvarchar(1),
    [BillingPlan]                    nvarchar(10),
    [BillingPlanItem]                char(6), -- collate Latin1_General_100_BIN2,
    [CustomerPriceGroup]             nvarchar(2),
    [PriceListType]                  nvarchar(2),
    [TaxDepartureCountry]            nvarchar(3),
    [VATRegistration]                nvarchar(20),
    [VATRegistrationCountry]         nvarchar(3),
    [VATRegistrationOrigin]          nvarchar(1),
    [CustomerTaxClassification1]     nvarchar(1),
    [CustomerTaxClassification2]     nvarchar(1),
    [CustomerTaxClassification3]     nvarchar(1),
    [CustomerTaxClassification4]     nvarchar(1),
    [CustomerTaxClassification5]     nvarchar(1),
    [CustomerTaxClassification6]     nvarchar(1),
    [CustomerTaxClassification7]     nvarchar(1),
    [CustomerTaxClassification8]     nvarchar(1),
    [CustomerTaxClassification9]     nvarchar(1),
    [SDPricingProcedure]             nvarchar(6),
    [NetAmount]                      decimal(15, 2),
    [TransactionCurrency]            char(5), -- collate Latin1_General_100_BIN2,
    [GrossAmount]                    decimal(15, 2),
    [PricingDate]                    date,
    [PriceDetnExchangeRate]          decimal(9, 5),
    [PricingScaleQuantityInBaseUnit] decimal(13, 3),
    [TaxAmount]                      decimal(13, 2),
    [CostAmount]                     decimal(13, 2),
    [Subtotal1Amount]                decimal(13, 2),
    [Subtotal2Amount]                decimal(13, 2),
    [Subtotal3Amount]                decimal(13, 2),
    [Subtotal4Amount]                decimal(13, 2),
    [Subtotal5Amount]                decimal(13, 2),
    [Subtotal6Amount]                decimal(13, 2),
    [StatisticalValueControl]        nvarchar(1),
    [StatisticsExchangeRate]         decimal(9, 5),
    [StatisticsCurrency]             char(5), -- collate Latin1_General_100_BIN2,
    [SalesOrganizationCurrency]      char(5), -- collate Latin1_General_100_BIN2,
    [EligibleAmountForCashDiscount]  decimal(13, 2),
    [ContractAccount]                nvarchar(12),
    [CustomerPaymentTerms]           nvarchar(4),
    [PaymentMethod]                  nvarchar(1),
    [PaymentReference]               nvarchar(30),
    [FixedValueDate]                 date,
    [AdditionalValueDays]            char(2), -- collate Latin1_General_100_BIN2,
    [PayerParty]                     nvarchar(10),
    [CompanyCode]                    nvarchar(4),
    [FiscalYear]                     char(4), -- collate Latin1_General_100_BIN2,
    [FiscalPeriod]                   char(3), -- collate Latin1_General_100_BIN2,
    [CustomerAccountAssignmentGroup] nvarchar(2),
    [BusinessArea]                   nvarchar(4),
    [ProfitCenter]                   nvarchar(10),
    [OrderID]                        nvarchar(12),
    [ControllingArea]                nvarchar(4),
    [ProfitabilitySegment]           char(10), -- collate Latin1_General_100_BIN2,
    [CostCenter]                     nvarchar(10),
    [OriginSDDocument]               nvarchar(10),
    [OriginSDDocumentItem]           char(6), -- collate Latin1_General_100_BIN2,
    [PriceDetnExchangeRateDate]      date,
    [ExchangeRateType]               nvarchar(4),
    [FiscalYearVariant]              nvarchar(2),
    [Currency]                       char(5), -- collate Latin1_General_100_BIN2,
    [AccountingExchangeRate]         decimal(9, 5),
    [AccountingExchangeRateIsSet]    nvarchar(1),
    [ReferenceSDDocument]            nvarchar(10),
    [ReferenceSDDocumentItem]        char(6), -- collate Latin1_General_100_BIN2,
    [ReferenceSDDocumentCategory]    nvarchar(4),
    [SalesDocument]                  nvarchar(10),
    [SalesDocumentItem]              char(6), -- collate Latin1_General_100_BIN2,
    [SalesSDDocumentCategory]        nvarchar(4),
    [HigherLevelItem]                char(6), -- collate Latin1_General_100_BIN2,
    [BillingDocumentItemInPartSgmt]  char(6), -- collate Latin1_General_100_BIN2,
    [SalesGroup]                     nvarchar(3),
    [AdditionalCustomerGroup1]       nvarchar(3),
    [AdditionalCustomerGroup2]       nvarchar(3),
    [AdditionalCustomerGroup3]       nvarchar(3),
    [AdditionalCustomerGroup4]       nvarchar(3),
    [AdditionalCustomerGroup5]       nvarchar(3),
    [SDDocumentReason]               nvarchar(3),
    [ItemIsRelevantForCredit]        nvarchar(1),
    [CreditRelatedPrice]             decimal(11, 2),
    [SalesDistrict]                  nvarchar(6),
    [CustomerGroup]                  nvarchar(2),
    [SoldToParty]                    nvarchar(10),
    [Country]                        nvarchar(3),
    [ShipToParty]                    nvarchar(10),
    [BillToParty]                    nvarchar(10),
    [ShippingPoint]                  nvarchar(4),
    [IncotermsVersion]               nvarchar(4),
    [IncotermsClassification]        nvarchar(3),
    [IncotermsTransferLocation]      nvarchar(28),
    [IncotermsLocation1]             nvarchar(70),
    [IncotermsLocation2]             nvarchar(70),
    [ShippingCondition]              nvarchar(2),
    [t_applicationId]                VARCHAR(32),
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_jobBy]                        VARCHAR(128),
    [t_extractionDtm]                DATETIME,
    [t_lastActionBy]                 VARCHAR(128),
    [t_lastActionCd]                 CHAR(1),
    [t_lastActionDtm]                DATETIME,
    [t_filePath]                     NVARCHAR(1024),
    CONSTRAINT [PK_C_BillingDocumentItemBasicDEX] PRIMARY KEY NONCLUSTERED (
        [MANDT], [BillingDocument],
        [BillingDocumentItem]
    ) NOT ENFORCED
)
    WITH ( HEAP )
