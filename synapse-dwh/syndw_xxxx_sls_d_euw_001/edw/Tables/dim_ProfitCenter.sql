CREATE TABLE [edw].[dim_ProfitCenter]
(
-- Profit Center
    [ControllingArea]                nvarchar(8)  NOT NULL,
    [ProfitCenterID]                 nvarchar(20) NOT NULL,-- renamed (ex ProfitCenter)
    [ProfitCenter]                   nvarchar(40),          --renamed (ex ProfitCenterName) from [base_s4h_cax].[I_ProfitCenterText]
    [ProfitCenterTypeID]             char(1),
    [ProfitCenterType]               nvarchar(14),
    [ProfitCenterLongName]           nvarchar(80),          -- from [base_s4h_cax].[I_ProfitCenterText]
    [ValidityEndDate]                date         NOT NULL,
    [ProfitCtrResponsiblePersonName] nvarchar(40),
    [CompanyCode]                    nvarchar(8),
    [ProfitCtrResponsibleUser]       nvarchar(24),
    [ValidityStartDate]              date,
    [Department]                     nvarchar(24),
    [ProfitCenterStandardHierarchy]  nvarchar(24),
    [Segment]                        nvarchar(20),
    [ProfitCenterIsBlocked]          nvarchar(2),
    [FormulaPlanningTemplate]        nvarchar(20),
    [FormOfAddress]                  nvarchar(30),
    [AddressName]                    nvarchar(70),
    [AdditionalName]                 nvarchar(70),
    [ProfitCenterAddrName3]          nvarchar(70),
    [ProfitCenterAddrName4]          nvarchar(70),
    [StreetAddressName]              nvarchar(70),
    [POBox]                          nvarchar(20),
    [CityName]                       nvarchar(70),
    [PostalCode]                     nvarchar(20),
    [District]                       nvarchar(70),
    [Country]                        nvarchar(6),
    [Region]                         nvarchar(6),
    [TaxJurisdiction]                nvarchar(30),
    [Language]                       char(1),
    [PhoneNumber1]                   nvarchar(32),
    [PhoneNumber2]                   nvarchar(32),
    [TeleboxNumber]                  nvarchar(30),
    [TelexNumber]                    nvarchar(60),
    [FaxNumber]                      nvarchar(62),
    [DataCommunicationPhoneNumber]   nvarchar(28),
    [ProfitCenterPrinterName]        nvarchar(8),
    [ProfitCenterCreatedByUser]      nvarchar(24),
    [ProfitCenterCreationDate]       date,
    [t_applicationId]                VARCHAR(32),
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_lastActionCd]                 VARCHAR(1),
    [t_jobBy]                        NVARCHAR(128),
    CONSTRAINT [PK_dim_ProfitCenter] PRIMARY KEY NONCLUSTERED ([ControllingArea], [ProfitCenterID], [ValidityEndDate]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
