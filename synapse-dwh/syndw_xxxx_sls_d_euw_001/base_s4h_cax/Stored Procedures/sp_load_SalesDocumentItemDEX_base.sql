CREATE PROC [base_s4h_uat_caa].[sp_load_SalesDocumentItemDEX_base] @t_applicationId [varchar](7),
                                                                   @t_jobId [varchar](36),
                                                                   @t_lastDtm [datetime],
                                                                   @t_lastActionBy [nvarchar](20),
                                                                   @t_filePath [nvarchar](1024)
AS
BEGIN

    TRUNCATE TABLE [base_s4h_uat_caa].[C_SalesDocumentItemDEX]

    INSERT INTO [base_s4h_uat_caa].[C_SalesDocumentItemDEX]( [SalesDocument]
                                                           , [SalesDocumentItem]
                                                           , [SDDocumentCategory]
                                                           , [SalesDocumentType]
                                                           , [SalesDocumentItemCategory]
                                                           , [IsReturnsItem]
                                                           , [CreationDate]
                                                           , [CreationTime]
                                                           , [LastChangeDate]
                                                           , [SalesOrganization]
                                                           , [DistributionChannel]
                                                           , [Division]
                                                           , [SalesGroup]
                                                           , [SalesOffice]
                                                           , [InternationalArticleNumber]
                                                           , [Batch]
                                                           , [Material]
        --, [Product]
                                                           , [OriginallyRequestedMaterial]
                                                           , [MaterialSubstitutionReason]
                                                           , [MaterialGroup]
        --, [ProductGroup]
                                                           , [AdditionalMaterialGroup1]
                                                           , [AdditionalMaterialGroup2]
                                                           , [AdditionalMaterialGroup3]
                                                           , [AdditionalMaterialGroup4]
                                                           , [AdditionalMaterialGroup5]
                                                           , [SoldToParty]
                                                           , [AdditionalCustomerGroup1]
                                                           , [AdditionalCustomerGroup2]
                                                           , [AdditionalCustomerGroup3]
                                                           , [AdditionalCustomerGroup4]
                                                           , [AdditionalCustomerGroup5]
                                                           , [ShipToParty]
                                                           , [PayerParty]
                                                           , [BillToParty]
                                                           , [SDDocumentReason]
                                                           , [SalesDocumentDate]
                                                           , [OrderQuantity]
                                                           , [OrderQuantityUnit]
                                                           , [TargetQuantity]
                                                           , [TargetQuantityUnit]
                                                           , [TargetToBaseQuantityDnmntr]
                                                           , [TargetToBaseQuantityNmrtr]
                                                           , [OrderToBaseQuantityDnmntr]
                                                           , [OrderToBaseQuantityNmrtr]
                                                           , [ConfdDelivQtyInOrderQtyUnit]
                                                           , [TargetDelivQtyInOrderQtyUnit]
                                                           , [ConfdDeliveryQtyInBaseUnit]
                                                           , [BaseUnit]
        --, [RequestedQuantityInBaseUnit]
                                                           , [ItemGrossWeight]
                                                           , [ItemNetWeight]
                                                           , [ItemWeightUnit]
                                                           , [ItemVolume]
                                                           , [ItemVolumeUnit]
                                                           , [ServicesRenderedDate]
                                                           , [SalesDistrict]
                                                           , [CustomerGroup]
                                                           , [HdrOrderProbabilityInPercent]
                                                           , [ItemOrderProbabilityInPercent]
                                                           , [SalesDocumentRjcnReason]
                                                           , [PricingDate]
                                                           , [ExchangeRateDate]
                                                           , [PriceDetnExchangeRate]
                                                           , [StatisticalValueControl]
                                                           , [NetAmount]
                                                           , [TransactionCurrency]
                                                           , [SalesOrganizationCurrency]
                                                           , [NetPriceAmount]
                                                           , [NetPriceQuantity]
                                                           , [NetPriceQuantityUnit]
                                                           , [TaxAmount]
                                                           , [CostAmount]
                                                           , [Subtotal1Amount]
                                                           , [Subtotal2Amount]
                                                           , [Subtotal3Amount]
                                                           , [Subtotal4Amount]
                                                           , [Subtotal5Amount]
                                                           , [Subtotal6Amount]
                                                           , [ShippingPoint]
                                                           , [ShippingType]
                                                           , [DeliveryPriority]
                                                           , [InventorySpecialStockType]
                                                           , [RequestedDeliveryDate]
                                                           , [ShippingCondition]
                                                           , [DeliveryBlockReason]
                                                           , [Plant]
                                                           , [StorageLocation]
                                                           , [Route]
                                                           , [IncotermsClassification]
                                                           , [IncotermsVersion]
                                                           , [IncotermsTransferLocation]
                                                           , [IncotermsLocation1]
                                                           , [IncotermsLocation2]
                                                           , [MinDeliveryQtyInBaseUnit]
                                                           , [UnlimitedOverdeliveryIsAllowed]
                                                           , [OverdelivTolrtdLmtRatioInPct]
                                                           , [UnderdelivTolrtdLmtRatioInPct]
                                                           , [PartialDeliveryIsAllowed]
                                                           , [BindingPeriodValidityStartDate]
                                                           , [BindingPeriodValidityEndDate]
        --, [CompletionRule]
                                                           , [OutlineAgreementTargetAmount]
                                                           , [BillingDocumentDate]
                                                           , [BillingCompanyCode]
                                                           , [HeaderBillingBlockReason]
                                                           , [ItemBillingBlockReason]
        --, [ItemIsBillingRelevant]
                                                           , [FiscalYear]
                                                           , [FiscalPeriod]
                                                           , [CustomerAccountAssignmentGroup]
                                                           , [ExchangeRateType]
                                                           , [Currency]
                                                           , [FiscalYearVariant]
                                                           , [BusinessArea]
                                                           , [ProfitCenter]
                                                           , [OrderID]
                                                           , [ProfitabilitySegment]
                                                           , [ControllingArea]
                                                           , [ReferenceSDDocument]
                                                           , [ReferenceSDDocumentItem]
                                                           , [ReferenceSDDocumentCategory]
                                                           , [OriginSDDocument]
                                                           , [OriginSDDocumentItem]
                                                           , [OverallSDProcessStatus]
                                                           , [OverallTotalDeliveryStatus]
                                                           , [OverallOrdReltdBillgStatus]
                                                           , [TotalCreditCheckStatus]
                                                           , [DeliveryBlockStatus]
                                                           , [BillingBlockStatus]
                                                           , [TotalSDDocReferenceStatus]
        --, [OverallDelivConfStatus]
        --, [OverallDeliveryStatus]
                                                           , [SDDocReferenceStatus]
                                                           , [OverallSDDocumentRejectionSts]
                                                           , [SDDocumentRejectionStatus]
                                                           , [OverallTotalSDDocRefStatus]
                                                           , [OverallSDDocReferenceStatus]
                                                           , [ItemGeneralIncompletionStatus]
                                                           , [ItemBillingIncompletionStatus]
                                                           , [PricingIncompletionStatus]
                                                           , [ItemDeliveryIncompletionStatus]
        --, [DeliveryConfirmationStatus]
        --, [OrderRelatedBillingStatus]
        --, [SDProcessStatus]
        --, [TotalDeliveryStatus]
        --, [DeliveryStatus]
                                                           , [t_applicationId]
                                                           , [t_jobId]
                                                           , [t_lastDtm]
                                                           --, [t_lastActionCd]
                                                           , [t_lastActionBy]
                                                           , [t_filePath])
    SELECT [SalesDocument]                                                                         --nvarchar(20)                                 NOT NULL
         , CONVERT([char](6), [SalesDocumentItem])             AS [SalesDocumentItem]              --char(6) collate SQL_Latin1_General_CP1_CS_AS NOT NULL
         , [SDDocumentCategory]                                                                    --nvarchar(8),
         , [SalesDocumentType]                                                                     --nvarchar(8),
         , [SalesDocumentItemCategory]                                                             --nvarchar(8),
         , [IsReturnsItem]                                                                         --nvarchar(2),
         , CASE [CreationDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [CreationDate], 112)
        END                                                    AS [CreationDate]
         , CASE LEN([CreationTime])
               WHEN 6 THEN CONVERT([time](0), LEFT([CreationTime], 2) + ':' + SUBSTRING([CreationTime], 3, 2) + ':' +
                                              SUBSTRING([CreationTime], 5, 2))
               WHEN 5 THEN CONVERT([time](0), LEFT([CreationTime], 1) + ':' + SUBSTRING([CreationTime], 2, 2) + ':' +
                                              SUBSTRING([CreationTime], 4, 2))
        END                                                    AS [CreationTime]
         , CASE [LastChangeDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [LastChangeDate], 112)
        END                                                    AS [LastChangeDate]
         , [SalesOrganization]                                                                     --nvarchar(8),
         , [DistributionChannel]                                                                   --nvarchar(4),
         , [Division]                                                                              --nvarchar(4),
         , [SalesGroup]                                                                            --nvarchar(6),
         , [SalesOffice]                                                                           --nvarchar(8),
         , [InternationalArticleNumber]                                                            --nvarchar(36),
         , [Batch]                                                                                 --nvarchar(20),
         , [Material]                                                                              --nvarchar(80),
         --, [Product]                                                                               --nvarchar(80),
         , [OriginallyRequestedMaterial]                                                           --nvarchar(80),
         , [MaterialSubstitutionReason]                                                            --nvarchar(8),
         , [MaterialGroup]                                                                         --nvarchar(18),
         --, [ProductGroup]                                                                          --nvarchar(18),
         , [AdditionalMaterialGroup1]                                                              --nvarchar(6),
         , [AdditionalMaterialGroup2]                                                              --nvarchar(6),
         , [AdditionalMaterialGroup3]                                                              --nvarchar(6),
         , [AdditionalMaterialGroup4]                                                              --nvarchar(6),
         , [AdditionalMaterialGroup5]                                                              --nvarchar(6),
         , [SoldToParty]                                                                           --nvarchar(20),
         , [AdditionalCustomerGroup1]                                                              --nvarchar(6),
         , [AdditionalCustomerGroup2]                                                              --nvarchar(6),
         , [AdditionalCustomerGroup3]                                                              --nvarchar(6),
         , [AdditionalCustomerGroup4]                                                              --nvarchar(6),
         , [AdditionalCustomerGroup5]                                                              --nvarchar(6),
         , [ShipToParty]                                                                           --nvarchar(20),
         , [PayerParty]                                                                            --nvarchar(20),
         , [BillToParty]                                                                           --nvarchar(20),
         , [SDDocumentReason]                                                                      --nvarchar(6),
         , CASE [SalesDocumentDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [SalesDocumentDate], 112)
        END                                                    AS [SalesDocumentDate]

         , CONVERT([decimal](15, 3), CASE
                                         WHEN RIGHT(RTRIM([OrderQuantity]), 1) = '-'
                                             THEN '-' + REPLACE([OrderQuantity], '-', '')
                                         ELSE [OrderQuantity]
        END)                                                   AS [OrderQuantity]                  --decimal(15, 3),
         , [OrderQuantityUnit]                                                                     --nvarchar(6) collate SQL_Latin1_General_CP1_CS_AS,
         , CONVERT([decimal](13, 3), CASE
                                         WHEN RIGHT(RTRIM([TargetQuantity]), 1) = '-'
                                             THEN '-' + REPLACE([TargetQuantity], '-', '')
                                         ELSE [TargetQuantity]
        END)                                                   AS [TargetQuantity]                 --decimal(13, 3),
         , [TargetQuantityUnit]                                                                    --nvarchar(6) collate SQL_Latin1_General_CP1_CS_AS,
         , CONVERT([decimal](5, 0), CASE
                                        WHEN RIGHT(RTRIM([TargetToBaseQuantityDnmntr]), 1) = '-'
                                            THEN '-' + REPLACE([TargetToBaseQuantityDnmntr], '-', '')
                                        ELSE [TargetToBaseQuantityDnmntr]
        END)                                                      [TargetToBaseQuantityDnmntr]     --decimal(5),
         , CONVERT([decimal](5, 0), CASE
                                        WHEN RIGHT(RTRIM([TargetToBaseQuantityNmrtr]), 1) = '-'
                                            THEN '-' + REPLACE([TargetToBaseQuantityNmrtr], '-', '')
                                        ELSE [TargetToBaseQuantityNmrtr]
        END)                                                      [TargetToBaseQuantityNmrtr]      --decimal(5),
         , CONVERT([decimal](5, 0), CASE
                                        WHEN RIGHT(RTRIM([OrderToBaseQuantityDnmntr]), 1) = '-'
                                            THEN '-' + REPLACE([OrderToBaseQuantityDnmntr], '-', '')
                                        ELSE [OrderToBaseQuantityDnmntr]
        END)                                                      [OrderToBaseQuantityDnmntr]      --decimal(5),
         , CONVERT([decimal](5, 0), CASE
                                        WHEN RIGHT(RTRIM([OrderToBaseQuantityNmrtr]), 1) = '-'
                                            THEN '-' + REPLACE([OrderToBaseQuantityNmrtr], '-', '')
                                        ELSE [OrderToBaseQuantityNmrtr]
        END)                                                      [OrderToBaseQuantityNmrtr]       --decimal(5),
         , CONVERT([decimal](15, 3), CASE
                                         WHEN RIGHT(RTRIM([ConfdDelivQtyInOrderQtyUnit]), 1) = '-'
                                             THEN '-' + REPLACE([ConfdDelivQtyInOrderQtyUnit], '-', '')
                                         ELSE [ConfdDelivQtyInOrderQtyUnit]
        END)                                                   AS [ConfdDelivQtyInOrderQtyUnit]    --decimal(15, 3),
         , CONVERT([decimal](15, 3), CASE
                                         WHEN RIGHT(RTRIM([TargetDelivQtyInOrderQtyUnit]), 1) = '-'
                                             THEN '-' + REPLACE([TargetDelivQtyInOrderQtyUnit], '-', '')
                                         ELSE [TargetDelivQtyInOrderQtyUnit]
        END)                                                   AS [TargetDelivQtyInOrderQtyUnit]   --decimal(15, 3),
         , CONVERT([decimal](15, 3), CASE
                                         WHEN RIGHT(RTRIM([ConfdDeliveryQtyInBaseUnit]), 1) = '-'
                                             THEN '-' + REPLACE([ConfdDeliveryQtyInBaseUnit], '-', '')
                                         ELSE [ConfdDeliveryQtyInBaseUnit]
        END)                                                   AS [ConfdDeliveryQtyInBaseUnit]     --decimal(15, 3),
         , [BaseUnit]                                                                              --nvarchar(6) collate SQL_Latin1_General_CP1_CS_AS,
--         , CONVERT([decimal](15, 3), CASE
--                                         WHEN RIGHT(RTRIM([RequestedQuantityInBaseUnit]), 1) = '-'
--                                             THEN '-' + REPLACE([RequestedQuantityInBaseUnit], '-', '')
--                                         ELSE [RequestedQuantityInBaseUnit]
--        END)                                                   AS [RequestedQuantityInBaseUnit]    --decimal(15, 3),
         , CONVERT([decimal](15, 3), CASE
                                         WHEN RIGHT(RTRIM([ItemGrossWeight]), 1) = '-'
                                             THEN '-' + REPLACE([ItemGrossWeight], '-', '')
                                         ELSE [ItemGrossWeight]
        END)                                                   AS [ItemGrossWeight]                --decimal(15, 3),
         , CONVERT([decimal](15, 3), CASE
                                         WHEN RIGHT(RTRIM([ItemNetWeight]), 1) = '-'
                                             THEN '-' + REPLACE([ItemNetWeight], '-', '')
                                         ELSE [ItemNetWeight]
        END)                                                   AS [ItemNetWeight]                  --decimal(15, 3),
         , [ItemWeightUnit]                                                                        --nvarchar(6) collate SQL_Latin1_General_CP1_CS_AS,
         , CONVERT([decimal](15, 3), CASE
                                         WHEN RIGHT(RTRIM([ItemVolume]), 1) = '-'
                                             THEN '-' + REPLACE([ItemVolume], '-', '')
                                         ELSE [ItemVolume]
        END)                                                   AS [ItemVolume]                     --decimal(15, 3),
         , [ItemVolumeUnit]                                                                        --nvarchar(6) collate SQL_Latin1_General_CP1_CS_AS,
         , CASE [ServicesRenderedDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [ServicesRenderedDate], 112)
        END                                                    as [ServicesRenderedDate]           --date,
         , [SalesDistrict]                                                                         --nvarchar(12),
         , [CustomerGroup]                                                                         --nvarchar(4),
         , CONVERT([char](3), [HdrOrderProbabilityInPercent])  AS [HdrOrderProbabilityInPercent]   --char(3) collate SQL_Latin1_General_CP1_CS_AS,
         , CONVERT([char](3), [ItemOrderProbabilityInPercent]) AS [ItemOrderProbabilityInPercent]  --char(3) collate SQL_Latin1_General_CP1_CS_AS,
         , [SalesDocumentRjcnReason]                                                               --nvarchar(4),
         , CASE [PricingDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [PricingDate], 112)
        END                                                    as [PricingDate]                    --date,
         , CASE [ExchangeRateDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [ExchangeRateDate], 112)
        END                                                    as [ExchangeRateDate]               --date,
         , CONVERT([decimal](9, 5), CASE
                                        WHEN RIGHT(RTRIM([PriceDetnExchangeRate]), 1) = '-'
                                            THEN '-' + REPLACE([PriceDetnExchangeRate], '-', '')
                                        ELSE [PriceDetnExchangeRate]
        END)                                                   as [PriceDetnExchangeRate]          --decimal(9, 5),
         , [StatisticalValueControl]                                                               --nvarchar(2),
         , CONVERT([decimal](15, 2), CASE
                                         WHEN RIGHT(RTRIM([NetAmount]), 1) = '-'
                                             THEN '-' + REPLACE([NetAmount], '-', '')
                                         ELSE [NetAmount]
        END)                                                   as [NetAmount]                      --decimal(15, 2),
         , CONVERT([char](5), [TransactionCurrency])           AS [TransactionCurrency]            --char(5) collate SQL_Latin1_General_CP1_CS_AS,
         , CONVERT([char](5), [SalesOrganizationCurrency])     AS [SalesOrganizationCurrency]      --char(5) collate SQL_Latin1_General_CP1_CS_AS,
         , CONVERT([decimal](11, 2), CASE
                                         WHEN RIGHT(RTRIM([NetPriceAmount]), 1) = '-'
                                             THEN '-' + REPLACE([NetPriceAmount], '-', '')
                                         ELSE [NetPriceAmount]
        END)                                                      [NetPriceAmount]                 --decimal(11, 2),
         , CONVERT([decimal](5, 0), CASE
                                        WHEN RIGHT(RTRIM([NetPriceQuantity]), 1) = '-'
                                            THEN '-' + REPLACE([NetPriceQuantity], '-', '')
                                        ELSE [NetPriceQuantity]
        END)                                                      [NetPriceQuantity]               --decimal(5),
         , [NetPriceQuantityUnit]                                                                  --nvarchar(6) collate SQL_Latin1_General_CP1_CS_AS,
         , CONVERT([decimal](13, 2), CASE
                                         WHEN RIGHT(RTRIM([TaxAmount]), 1) = '-'
                                             THEN '-' + REPLACE([TaxAmount], '-', '')
                                         ELSE [TaxAmount]
        END)                                                   AS [TaxAmount]                      --decimal(13, 2),
         , CONVERT([decimal](13, 2), CASE
                                         WHEN RIGHT(RTRIM([CostAmount]), 1) = '-'
                                             THEN '-' + REPLACE([CostAmount], '-', '')
                                         ELSE [CostAmount]
        END)                                                   AS [CostAmount]                     --decimal(13, 2),
         , CONVERT([decimal](13, 2), CASE
                                         WHEN RIGHT(RTRIM([Subtotal1Amount]), 1) = '-'
                                             THEN '-' + REPLACE([Subtotal1Amount], '-', '')
                                         ELSE [Subtotal1Amount]
        END)                                                   AS [Subtotal1Amount]                --decimal(13, 2),
         , CONVERT([decimal](13, 2), CASE
                                         WHEN RIGHT(RTRIM([Subtotal2Amount]), 1) = '-'
                                             THEN '-' + REPLACE([Subtotal2Amount], '-', '')
                                         ELSE [Subtotal2Amount]
        END)                                                   AS [Subtotal2Amount]                --decimal(13, 2),
         , CONVERT([decimal](13, 2), CASE
                                         WHEN RIGHT(RTRIM([Subtotal3Amount]), 1) = '-'
                                             THEN '-' + REPLACE([Subtotal3Amount], '-', '')
                                         ELSE [Subtotal3Amount]
        END)                                                   AS [Subtotal3Amount]                --decimal(13, 2),
         , CONVERT([decimal](13, 2), CASE
                                         WHEN RIGHT(RTRIM([Subtotal4Amount]), 1) = '-'
                                             THEN '-' + REPLACE([Subtotal4Amount], '-', '')
                                         ELSE [Subtotal4Amount]
        END)                                                   AS [Subtotal4Amount]                --decimal(13, 2),
         , CONVERT([decimal](13, 2), CASE
                                         WHEN RIGHT(RTRIM([Subtotal5Amount]), 1) = '-'
                                             THEN '-' + REPLACE([Subtotal5Amount], '-', '')
                                         ELSE [Subtotal5Amount]
        END)                                                   AS [Subtotal5Amount]                --decimal(13, 2),
         , CONVERT([decimal](13, 2), CASE
                                         WHEN RIGHT(RTRIM([Subtotal6Amount]), 1) = '-'
                                             THEN '-' + REPLACE([Subtotal6Amount], '-', '')
                                         ELSE [Subtotal6Amount]
        END)                                                   AS [Subtotal6Amount]                --decimal(13, 2),
         , [ShippingPoint]                                                                         --nvarchar(8),
         , [ShippingType]                                                                          --nvarchar(4),
         , CONVERT([char](2), [DeliveryPriority])              AS [DeliveryPriority]               --char(2) collate SQL_Latin1_General_CP1_CS_AS,
         , [InventorySpecialStockType]                                                             --nvarchar(2),
         , CASE [RequestedDeliveryDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [RequestedDeliveryDate], 112)
        END                                                    as [RequestedDeliveryDate]          --date,
         , [ShippingCondition]                                                                     --nvarchar(4),
         , [DeliveryBlockReason]                                                                   --nvarchar(4),
         , [Plant]                                                                                 --nvarchar(8),
         , [StorageLocation]                                                                       --nvarchar(8),
         , [Route]                                                                                 --nvarchar(12),
         , [IncotermsClassification]                                                               --nvarchar(6),
         , [IncotermsVersion]                                                                      --nvarchar(8),
         , [IncotermsTransferLocation]                                                             --nvarchar(56),
         , [IncotermsLocation1]                                                                    --nvarchar(140),
         , [IncotermsLocation2]                                                                    --nvarchar(140),
         , CONVERT([decimal](13, 3), CASE
                                         WHEN RIGHT(RTRIM([MinDeliveryQtyInBaseUnit]), 1) = '-'
                                             THEN '-' + REPLACE([MinDeliveryQtyInBaseUnit], '-', '')
                                         ELSE [MinDeliveryQtyInBaseUnit]
        END)                                                   AS [MinDeliveryQtyInBaseUnit]       --decimal(13, 3),
         , [UnlimitedOverdeliveryIsAllowed]                                                        --nvarchar(2),
         , CONVERT([decimal](13, 1), CASE
                                         WHEN RIGHT(RTRIM([OverdelivTolrtdLmtRatioInPct]), 1) = '-'
                                             THEN '-' + REPLACE([OverdelivTolrtdLmtRatioInPct], '-', '')
                                         ELSE [OverdelivTolrtdLmtRatioInPct]
        END)                                                   AS [OverdelivTolrtdLmtRatioInPct]   --decimal(3, 1),
         , CONVERT([decimal](13, 1), CASE
                                         WHEN RIGHT(RTRIM([UnderdelivTolrtdLmtRatioInPct]), 1) = '-'
                                             THEN '-' + REPLACE([UnderdelivTolrtdLmtRatioInPct], '-', '')
                                         ELSE [UnderdelivTolrtdLmtRatioInPct]
        END)                                                   AS [UnderdelivTolrtdLmtRatioInPct]  --decimal(3, 1),
         , [PartialDeliveryIsAllowed]                                                              --nvarchar(2),
         , CASE [BindingPeriodValidityStartDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [BindingPeriodValidityStartDate], 112)
        END                                                    as [BindingPeriodValidityStartDate] --date,
         , CASE [BindingPeriodValidityEndDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [BindingPeriodValidityEndDate], 112)
        END                                                    as [BindingPeriodValidityEndDate]   --date,
--         , [CompletionRule]                                                                        --nvarchar(2),
         , CONVERT([decimal](13, 2), CASE
                                         WHEN RIGHT(RTRIM([OutlineAgreementTargetAmount]), 1) = '-'
                                             THEN '-' + REPLACE([OutlineAgreementTargetAmount], '-', '')
                                         ELSE [OutlineAgreementTargetAmount]
        END)                                                   as [OutlineAgreementTargetAmount]   --decimal(13, 2),
         , CASE [BillingDocumentDate]
               WHEN '00000000' THEN '19000101'
               ELSE CONVERT([date], [BillingDocumentDate], 112)
        END                                                    as [BillingDocumentDate]            --date,
         , [BillingCompanyCode]                                                                    --nvarchar(8),
         , [HeaderBillingBlockReason]                                                              --nvarchar(4),
         , [ItemBillingBlockReason]                                                                --nvarchar(4),
         --, [ItemIsBillingRelevant]                                                                 --nvarchar(2),
         , CONVERT([char](4), [FiscalYear])                    AS [FiscalYear]                     --char(4) collate SQL_Latin1_General_CP1_CS_AS,
         , CONVERT([char](3), [FiscalPeriod])                  AS [FiscalPeriod]                   --char(3) collate SQL_Latin1_General_CP1_CS_AS,
         , [CustomerAccountAssignmentGroup]                                                        --nvarchar(4),
         , [ExchangeRateType]                                                                      --nvarchar(8),
         , CONVERT([char](5), [Currency])                      AS [Currency]                       --char(5) collate SQL_Latin1_General_CP1_CS_AS,
         , [FiscalYearVariant]                                                                     --nvarchar(4),
         , [BusinessArea]                                                                          --nvarchar(8),
         , [ProfitCenter]                                                                          --nvarchar(20),
         , [OrderID]                                                                               --nvarchar(24),
         , CONVERT([char](10), [ProfitabilitySegment])         AS [ProfitabilitySegment]           --char(10) collate SQL_Latin1_General_CP1_CS_AS,
         , [ControllingArea]                                                                       --nvarchar(8),
         , [ReferenceSDDocument]                                                                   --nvarchar(20),
         , CONVERT([char](6), [ReferenceSDDocumentItem])       AS [ReferenceSDDocumentItem]        --char(6) collate SQL_Latin1_General_CP1_CS_AS,
         , [ReferenceSDDocumentCategory]                                                           --nvarchar(8),
         , [OriginSDDocument]                                                                      --nvarchar(20),
         , CONVERT([char](6), [OriginSDDocumentItem])          AS [OriginSDDocumentItem]           --char(6) collate SQL_Latin1_General_CP1_CS_AS,
         , [OverallSDProcessStatus]                                                                --nvarchar(2),
         , [OverallTotalDeliveryStatus]                                                            --nvarchar(2),
         , [OverallOrdReltdBillgStatus]                                                            --nvarchar(2),
         , [TotalCreditCheckStatus]                                                                --nvarchar(2),
         , [DeliveryBlockStatus]                                                                   --nvarchar(2),
         , [BillingBlockStatus]                                                                    --nvarchar(2),
         , [TotalSDDocReferenceStatus]                                                             --nvarchar(2),
         , [SDDocReferenceStatus]                                                                  --nvarchar(2),
         , [OverallSDDocumentRejectionSts]                                                         --nvarchar(2),
         , [SDDocumentRejectionStatus]                                                             --nvarchar(2),
         , [OverallTotalSDDocRefStatus]                                                            --nvarchar(2),
         , [OverallSDDocReferenceStatus]                                                           --nvarchar(2),
         --, [OverallDelivConfStatus]                                                                --nvarchar(2),
         --, [OverallDeliveryStatus]                                                                 --nvarchar(2),
         , [ItemGeneralIncompletionStatus]                                                         --nvarchar(2),
         , [ItemBillingIncompletionStatus]                                                         --nvarchar(2),
         , [PricingIncompletionStatus]                                                             --nvarchar(2),
         , [ItemDeliveryIncompletionStatus]                                                        --nvarchar(2),
         --, [DeliveryConfirmationStatus]                                                            --nvarchar(2),
         --, [OrderRelatedBillingStatus]                                                             --nvarchar(2),
         --, [SDProcessStatus]                                                                       --nvarchar(2),
         --, [TotalDeliveryStatus]                                                                   --nvarchar(2),
         --, [DeliveryStatus]                                                                        --nvarchar(2),
         , @t_applicationId                                    AS t_applicationId
         , @t_jobId                                            AS t_jobId
         , @t_lastDtm                                          AS t_lastDtm
         , @t_lastActionBy                                     AS t_lastActionBy
         , @t_filePath                                         AS t_filePath
    FROM [base_s4h_uat_caa].[C_SalesDocumentItemDEX_staging]
END


