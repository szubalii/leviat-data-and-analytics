﻿CREATE VIEW [edw].[vw_PurchasingDocument]
	AS 
SELECT
   PD.[PurchasingDocument] as [PurchasingDocumentID],
   PD.[PurchasingDocumentCategory],
   PD.[PurchasingDocumentType],/* -- not actually need at this moment
   PD.[PurchasingDocumentSubtype],
   PD.[CompanyCode],
   PD.[PurchasingDocumentDeletionCode],
   PD.[PurchasingDocumentIsAged],
   PD.[ItemNumberInterval],
   PD.[ItemNumberIntervalForSubItems],
   PD.[PurchasingDocumentOrigin],
   PD.[ReleaseIsNotCompleted],
   PD.[ReleaseCode],
   PD.[PurchasingReleaseStrategy],
   PD.[PurgReleaseSequenceStatus],
   PD.[TaxReturnCountry],
   PD.[CreationDate],
   PD.[LastChangeDateTime],
   PD.[CreatedByUser],
   PD.[Supplier],
   PD.[SupplierRespSalesPersonName],
   PD.[SupplierPhoneNumber],
   PD.[SupplierAddressID],
   PD.[ManualSupplierAddressID],
   PD.[CorrespncExternalReference],
   PD.[CorrespncInternalReference],
   PD.[PurchasingOrganization],
   PD.[PurchasingGroup],
   PD.[DocumentCurrency],
   PD.[ExchangeRate],
   PD.[PurchasingDocumentOrderDate],
   PD.[SupplyingSupplier],
   PD.[SupplyingPlant],
   PD.[InvoicingParty],
   PD.[Customer],
   PD.[PurchaseContract],
   PD.[Language],
   PD.[PurgReasonForDocCancellation],
   PD.[PurchasingCompletenessStatus],
   PD.[IncotermsClassification],
   PD.[IncotermsTransferLocation],
   PD.[PaymentTerms],
   PD.[CashDiscount1Days],
   PD.[CashDiscount2Days],
   PD.[NetPaymentDays],
   PD.[CashDiscount1Percent],
   PD.[CashDiscount2Percent],
   PD.[PricingProcedure],
   PD.[TargetAmount],
   PD.[PurgDocumentDistributionType],
   PD.[PurchasingDocumentCondition],
   PD.[ValidityStartDate],
   PD.[ValidityEndDate],
   PD.[ScheduleAgreementHasReleaseDoc],
   PD.[QuotationLatestSubmissionDate],
   PD.[BindingPeriodValidityEndDate],
   PD.[QuotationSubmissionDate],
   PD.[SupplierQuotationExternalID],
   PD.[RequestForQuotation],
   PD.[ExchangeRateIsFixed],
   PD.[IncotermsVersion],
   PD.[IncotermsLocation1],
   PD.[IncotermsLocation2],
   PD.[PurchasingProcessingStatus],
   PD.[PurgReleaseTimeTotalAmount],
   PD.[DownPaymentType],
   PD.[DownPaymentPercentageOfTotAmt],
   PD.[DownPaymentAmount],
   PD.[DownPaymentDueDate],
   PD.[PurchasingDocumentName],
   PD.[QuotationEarliestSubmsnDate],
   PD.[LatestRegistrationDate],
   PD.[FollowOnDocumentCategory],
   PD.[FollowOnDocumentType],
   PD.[VATRegistration],
   PD.[VATRegistrationCountry],
   PD.[IsIntrastatReportingRelevant],
   PD.[IsIntrastatReportingExcluded],
   PD.[IsEndOfPurposeBlocked] */
   PD.[t_applicationId]
FROM [base_s4h_cax].[I_PurchasingDocument] PD
