﻿CREATE TABLE [base_c4c].[OpportunityCollection]
(
    [ObjectID]                                      NVARCHAR(70)        NOT NULL,
    [ProcessingTypeCode]                            NVARCHAR(4)         NULL,
    [ProcessingTypeCodeText]                        VARCHAR(12)         NULL,
    [ID]                                            NVARCHAR(35)        NULL,
    [ExternalID]                                    NVARCHAR(35)        NULL,
    [UUID]                                          NVARCHAR(68)        NULL,
    [ProspectPartyID]                               NVARCHAR(60)        NOT NULL,
    [Name]                                          VARCHAR(255)        NOT NULL,
    [PrimaryContactPartyID]                         VARCHAR(60)         NULL,
    [PriorityCode]                                  CHAR(1)             NULL,
    [PriorityCodeText]                              VARCHAR(10)         NULL,
    [OriginTypeCode]                                CHAR(3)             NULL,
    [OriginTypeCodeText]                            VARCHAR(20)         NULL,
    [LifeCycleStatusCode]                           CHAR(2)             NULL,
    [LifeCycleStatusCodeText]                       VARCHAR(10)         NULL,
    [ExternalUserStatusCode]                        CHAR(5)             NULL,
    [ExternalUserStatusCodeText]                    VARCHAR(10)         NULL,
    [ResultReasonCode]                              CHAR(3)             NULL,
    [ResultReasonCodeText]                          VARCHAR(55)         NULL,
    [SalesCycleCode]                                CHAR(3)             NULL,
    [SalesCycleCodeText]                            VARCHAR(20)         NULL,
    [SalesCyclePhaseCode]                           CHAR(3)             NULL,
    [SalesCyclePhaseCodeText]                       VARCHAR(24)         NULL,
    [ProcessStatusValidSinceDate]                   DATETIME            NULL,
    [SalesCyclePhaseStartDate]                      DATETIME            NULL,
    [ProbabilityPercent]                            DECIMAL(16, 6)      NULL,
    [HeaderRevenueSchedule]                         CHAR(5)             NULL,
    [SalesRevenueForecastRelevanceIndicator]        CHAR(5)             NULL,
    [ExpectedRevenueAmount]                         DECIMAL(28, 6)      NULL,
    [ExpectedRevenueAmountCurrencyCode]             CHAR(3)             NULL,
    [ExpectedRevenueAmountCurrencyCodeText]         VARCHAR(14)         NULL,
    [TotalExpectedNetAmount]                        DECIMAL(28, 6)      NULL,
    [TotalExpectedNetAmountAmountCurrencyCode]      CHAR(3)             NULL,
    [TotalExpectedNetAmountAmountCurrencyCodeText]  VARCHAR(14)         NULL,
    [WeightedExpectedNetAmount]                     DECIMAL(28, 6)      NULL,
    [WeightedExpectedNetAmountCurrencyCode]         CHAR(3)             NULL,
    [WeightedExpectedNetAmountCurrencyCodeText]     VARCHAR(14)         NULL,
    [ExpectedProcessingStartDate]                   DATETIME            NULL,
    [ExpectedProcessingEndDate]                     DATETIME            NULL,
    [ExpectedRevenueStartDate]                      DATETIME            NULL,
    [ExpectedRevenueEndDate]                        DATETIME            NULL,
    [SalesForecastCategoryCode]                     CHAR(4)             NULL,
    [SalesForecastCategoryCodeText]                 CHAR(8)             NULL,
    [GroupCode]                                     CHAR(4)             NULL,
    [GroupCodeText]                                 CHAR(26)            NULL,
    [SalesUnitPartyID]                              VARCHAR(60)         NULL,
    [SalesOrganisationID]                           VARCHAR(20)         NULL,
    [DistributionChannelCode]                       CHAR(2)             NULL,
    [DistributionChannelCodeText]                   CHAR(5)             NULL,
    [DivisionCode]                                  CHAR(2)             NULL,
    [DivisionCodeText]                              CHAR(15)            NULL,
    [SalesOfficeID]                                 VARCHAR(20)         NULL,
    [SalesGroupID]                                  VARCHAR(20)         NULL,
    [SalesTerritoryID]                              VARCHAR(6)          NULL,
    [MainEmployeeResponsiblePartyID]                VARCHAR(60)         NOT NULL,
    [EndBuyerPartyID]                               VARCHAR(60)         NULL,
    [ProductRecepientPartyID]                       VARCHAR(60)         NULL,
    [ApproverPartyID]                               VARCHAR(60)         NULL,
    [PayerPartyID]                                  VARCHAR(60)         NULL,
    [BillToPartyID]                                 VARCHAR(60)         NULL,
    [SellerPartyID]                                 VARCHAR(60)         NULL,
    [PhaseProgressEvaluationStatusCode]             CHAR(2)             NULL,
    [PhaseProgressEvaluationStatusCodeText]         CHAR(12)            NULL,
    [ProspectBudgetAmount]                          DECIMAL(28, 6)      NULL,
    [ProspectBudgetAmountCurrencyCode]              CHAR(3)             NULL,
    [ProspectBudgetAmountCurrencyCodeText]          CHAR(14)            NULL,
    [Score]                                         INT                 NULL,
    [MainEmployeeResponsiblePartyName]              VARCHAR(480)        NULL,
    [SalesUnityPartyName]                           VARCHAR(480)        NULL,
    [BillToPartyName]                               VARCHAR(480)        NULL,
    [ProductRecipientPartyName]                     VARCHAR(40)         NULL,
    [SellerPartyName]                               VARCHAR(480)        NULL,
    [PayerPartyName]                                VARCHAR(480)        NULL,
    [EndBuyerPartyName]                             VARCHAR(480)        NULL,
    [PrimaryContactPartyName]                       VARCHAR(480)        NULL,
    [ProspectPartyName]                             VARCHAR(480)        NULL,
    [ApproverPartyName]                             VARCHAR(480)        NULL,
    [SalesOrganisationName]                         VARCHAR(40)         NULL,
    [SalesOfficeName]                               VARCHAR(40)         NULL,
    [SalesGroupName]                                VARCHAR(40)         NULL,
    [SalesTerritoryName]                            VARCHAR(40)         NULL,
    [ConsistencyStatusCode]                         CHAR(2)             NULL,
    [ConsistencyStatusCodeText]                     CHAR(12)            NULL,
    [ApprovalStatusCode]                            CHAR(2)             NULL,
    [ApprovalStatusCodeText]                        CHAR(14)            NULL,
    [CreationDate]                                  DATETIME            NOT NULL,
    [LastChangeDate]                                DATETIME            NOT NULL,
    [CreationDateTime]                              DATETIMEOFFSET(7)   NOT NULL,
    [LastChangeDateTime]                            DATETIMEOFFSET(7)   NULL,
    [CreatedBy]                                     VARCHAR(480)        NULL,
    [LastChangedBy]                                 VARCHAR(80)         NULL,
    [CreatedByUUID]                                 NVARCHAR(68)        NULL,
    [LastChangedByUUID]                             NVARCHAR(68)        NULL,
    [EntityLastChangedOn]                           DATETIMEOFFSET(7)   NULL,
    [ETag]                                          DATETIMEOFFSET(7)   NULL,
    [BestConnectedColleague]                        VARCHAR(255)        NULL,
    [DealScore]                                     DECIMAL(16, 6)      NULL,
    [DealScoreReason]                               VARCHAR(255)        NULL,
    [FirstEmailReceivedOn]                          DATETIMEOFFSET(7)   NULL,
    [FirstEmailSentOn]                              DATETIMEOFFSET(7)   NULL,
    [LastDataHugSyncDateTime]                       DATETIMEOFFSET(7)   NULL,
    [LastEmailReceivedFrom]                         VARCHAR(255)        NULL,
    [LastEmailReceivedOn]                           DATETIMEOFFSET(7)   NULL,
    [LastEmailSentBy]                               VARCHAR(255)        NULL,
    [LastEmailSentOn]                               DATETIMEOFFSET(7)   NULL,
    [LastMeetingOn]                                 DATETIMEOFFSET(7)   NULL,
    [NextMeetingOn]                                 DATETIMEOFFSET(7)   NULL,
    [NumberOfColleagues]                            INT                 NULL,
    [NumberOfMeetings]                              INT                 NULL,
    [NumberOfOtherPeopleAtCompany]                  INT                 NULL,
    [NumberOfReceivedEmails]                        INT                 NULL,
    [NumberOfSentEmails]                            INT                 NULL,
    [AutoCreateContacts]                            CHAR(5)             NULL,
    [HugRank]                                       INT                 NULL,
    [ExternalProbabilityPercent]                    DECIMAL(16, 6)      NULL,
    [Zclassification_KUT]                           CHAR(30)            NULL,
    [Zclassification_KUTText]                       CHAR(1)             NULL,
    [Zexpectedorderdate_KUT]                        DATETIME            NULL,
    [Zframe_KUT]                                    CHAR(30)            NULL,
    [Zframe_KUTText]                                CHAR(16)            NULL,
    [Zinterproject_KUT]                             CHAR(5)             NULL,
    [ZlegacyIDopp_KUT]                              VARCHAR(80)         NULL,
    [Zleviatspecified_KUT]                          VARCHAR(256)        NULL,
    [Zoppclosedate_KUT]                             DATETIME            NULL,
    [Zoppstartdate_KUT]                             DATETIME            NULL,
    [Zopptype_KUT]                                  VARCHAR(30)         NULL,
    [Zopptype_KUTText]                              VARCHAR(11)         NULL,
    [Zparentopportunity_KUT]                        VARCHAR(40)         NULL,
    [Zproductpillar_KUT]                            VARCHAR(256)        NULL,
    [ZprojectID_KUT]                                VARCHAR(40)         NULL,
    [Zprojectcountry_KUT]                           VARCHAR(30)         NULL,
    [Zprojectcountry_KUTText]                       VARCHAR(1)          NULL,
    [Zprojectdescription_KUT]                       VARCHAR(255)        NULL,
    [Zprojectpostalcode_KUT]                        VARCHAR(40)         NULL,
    [Zprojectstreet_KUT]                            VARCHAR(80)         NULL,
    [Zprojecttype1_KUT]                             VARCHAR(30)         NULL,
    [Zprojecttype1_KUTText]                         VARCHAR(26)         NULL,
    [Zprojecttype2_KUT]                             VARCHAR(30)         NULL,
    [Zprojecttype2_KUTText]                         VARCHAR(22)         NULL,
    [Zprojetcity_KUT]                               VARCHAR(80)         NULL,
    [Zsubmissiondate_KUT]                           DATETIME            NULL,
    [Zuserquoterequestor_KUT]                       VARCHAR(40)         NULL,
    [zbim_KUT]                                      VARCHAR(30)         NULL,
    [zbim_KUTText]                                  VARCHAR(16)         NULL,
    [t_applicationId]                               VARCHAR(32)         NULL,
    [t_jobId]                                       VARCHAR(36)         NULL,
    [t_jobDtm]                                      DATETIME,
    [t_jobBy]                                       NVARCHAR(128)       NULL,
    [t_extractionDtm]                               DATETIME,
    [t_filePath]                                    NVARCHAR(1024)      NULL,
    CONSTRAINT [PK_OpprotunityCollection] PRIMARY KEY NONCLUSTERED ([ObjectID]) NOT ENFORCED
)
    WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);