﻿CREATE VIEW [edw].[vw_OpportunityCollection]
AS
SELECT
        [ObjectID]
    ,   [ID]
    ,   [ProcessingTypeCode] AS [ProcessingTypeID]
    ,   [ProcessingTypeCodeText] AS [ProcessingType]
    ,   [ProspectPartyID] AS [ProspectPartyCustomerID]
    ,   [Name] AS [C4C_ProjectName]
    ,   [OriginTypeCode] AS [OriginTypeID]
    ,   [OriginTypeCodeText] AS [OriginType]
    ,   [ExternalUserStatusCode] AS [ExternalUserStatusID]
    ,   [ExternalUserStatusCodeText] AS [ExternalUserStatus]
    ,   [ResultReasonCode] AS [ResultReasonID]
    ,   [ResultReasonCodeText] AS [ResultReason]
    ,   [ExpectedRevenueAmount]
    ,   [ExpectedRevenueAmountCurrencyCode] AS [ExpectedRevenueAmountCurrencyID]
    ,   [WeightedExpectedNetAmount]
    ,   [WeightedExpectedNetAmountCurrencyCode] AS [WeightedExpectedNetAmountCurrencyID]
    ,   [SalesOrganisationID]
    ,   [DistributionChannelCode] AS [DistributionChannelID]
    ,   [ProspectPartyName] AS [ProspectPartyCustomer]
    ,   [Zopptype_KUT] AS [Zopptype_KUTID]
    ,   [Zopptype_KUTText] AS [Zopptype_KUT]
    ,   [ZprojectID_KUT] AS [ZprojectParentID]
    ,   [t_applicationId]
    ,   [t_extractionDtm]
FROM
    [base_c4c].[OpportunityCollection]