CREATE TABLE [edw].[fact_OpportunityCollection]
(   
    [ObjectID]                                      NVARCHAR(70)        NOT NULL,
    [ID]                                            NVARCHAR(35)        NULL,
    [ProcessingTypeID]                              NVARCHAR(4)         NULL,
    [ProcessingType]                                NVARCHAR(11)        NULL,
    [ProspectPartyCustomerID]                       NVARCHAR(60)        NOT NULL,
    [C4C_ProjectName]                               VARCHAR(255)        NOT NULL,
    [OriginTypeID]                                  CHAR(3)             NULL,
    [OriginType]                                    NVARCHAR(18)        NULL,
    [ExternalUserStatusID]                          CHAR(5)             NULL,
    [ExternalUserStatus]                            NVARCHAR(11)        NULL,
    [ResultReasonID]                                CHAR(3)             NULL,
    [ResultReason]                                  NVARCHAR(54)        NULL,
    [ExpectedRevenueAmount]                         DECIMAL(28, 6)      NULL,
    [ExpectedRevenueAmountCurrencyID]               CHAR(3)             NULL,    
    [WeightedExpectedNetAmount]                     DECIMAL(28, 6)      NULL,
    [WeightedExpectedNetAmountCurrencyID]           CHAR(3)             NULL,
    [SalesOrganisationID]                           VARCHAR(20)         NULL,
    [DistributionChannelID]                         CHAR(2)             NULL,
    [ProspectPartyCustomer]                         VARCHAR(480)        NULL,
    [Zopptype_KUTID]                                VARCHAR(30)         NULL,
    [Zopptype_KUT]                                  NVARCHAR(11)        NULL,
    [ZprojectParentID]                              VARCHAR(40)         NULL,
    [t_applicationId]                               VARCHAR(32),
    [t_extractionDtm]                               DATETIME,
    [t_jobId]                                       VARCHAR(36),
    [t_jobDtm]                                      DATETIME,
    [t_lastActionCd]                                VARCHAR(1),
    [t_jobBy]                                       VARCHAR(128),
    CONSTRAINT [PK_fact_OpportunityCollection] PRIMARY KEY NONCLUSTERED (
        [ObjectID]
    )  NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([ObjectID]), CLUSTERED COLUMNSTORE INDEX )