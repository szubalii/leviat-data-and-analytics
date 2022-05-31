CREATE TABLE [edw].[dim_BillingDocumentPartnerFs]
(
[SDDocument]            NVARCHAR(10) NOT NULL
,[PartnerFunction]      NVARCHAR(2)  NOT NULL
,[PartnerFunctionName]  NVARCHAR(20)
,[AddressID]            NVARCHAR(10)
,[Customer]             NVARCHAR(10)
,[Personnel]            CHAR(8) collate Latin1_General_100_BIN2
,[FullName]             NVARCHAR(80)
,[CityName]             NVARCHAR(40)
,[StreetName]           NVARCHAR(60)
,[PostalCode]           NVARCHAR(10)
,[EmailAddress]         NVARCHAR(241)
,[PhoneNumber]          NVARCHAR(30)
,[MobilePhoneNumber]    NVARCHAR(30)
,[t_applicationId]      VARCHAR (32)
,[t_extractionDtm]      DATETIME
,[t_jobId]              VARCHAR(36)
,[t_jobDtm]             DATETIME
,[t_lastActionCd]       VARCHAR(1)
,[t_jobBy]              NVARCHAR(128)
,CONSTRAINT [PK_dim_BillingDocumentPartnerFs] PRIMARY KEY NONCLUSTERED ([SDDocument], [PartnerFunction]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO

